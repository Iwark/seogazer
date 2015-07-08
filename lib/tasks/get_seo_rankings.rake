namespace :crawl do

  task test: :environment do
    p "test"
  end

  task start: :environment do

    # 検索結果を30ページ(300件)取得
    CRAWL_PAGE  = 30

    # 一回のリクエストで取得する検索結果の数
    FETCH_NUM_PER_REQUEST = 10

    # １つのIPアドレス(Proxy)がリクエスト可能な回数
    REQUESTABLE_NUM_PER_INSTANCE = 10

    # １つのキーワードを検索するのに必要なリクエスト回数
    REQUEST_NUM_PER_KEYWORD = CRAWL_PAGE / FETCH_NUM_PER_REQUEST

    # USER_AGENT
    USER_AGENT = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1"

    # キーワード一覧の取得
    keywords = Keyword.pluck_to_hash(:id, :name, :url)

    # AWS インスタンスの一覧
    f = File.open("config/ec2_instances.yml", "r")
      instances = YAML::load_file(f)
    f.close

    # インスタンスの数
    instance_count = instances.length

    # 必要なIPアドレス(Proxy)の数
    required_instance_count    = keywords.length * REQUEST_NUM_PER_KEYWORD

    # インスタンスあたりのリクエスト回数
    request_count_per_instance = (required_instance_count/instance_count).to_i + 1

    result = Benchmark.realtime do
      request_count_per_instance.times do |loop_num|

        threads = []
        instances.each_with_index do |instance_id, instance_num|

          threads << Thread.new do

            # 何番目のリクエストか？
            request_num = loop_num * instance_count + instance_num
            
            keyword_index = (request_num / REQUEST_NUM_PER_KEYWORD).to_i
            if keyword_index < keywords.length

              # リクエストするキーワード
              keyword = keywords[keyword_index]

              # EC2インスタンスの取得
              client    = Aws::EC2::Client.new
              instance  = Aws::EC2::Resource.new.instance(instance_id)

              # EC2インスタンスの停止
              instance.stop if instance.state.name != "stopped"
              client.wait_until(:instance_stopped,  instance_ids:[instance_id])

              # EC2インスタンスの起動
              instance.start
              while true
                status = client.describe_instance_status(instance_ids:[instance_id]).instance_statuses[0]
                if status
                  system_status   = status.system_status.status
                  instance_status = status.instance_status.status
                  break if system_status == "ok" && instance_status == "ok"
                end
                sleep(3)
              end

              # Proxyの取得
              instance  = Aws::EC2::Resource.new.instance(instance_id)
              proxy_url = "http://#{instance.public_dns_name}:#{Rails.application.secrets.proxy_port}"

              p "instance started. proxy_url: #{proxy_url}"

              # Rankingの取得
              10.times do |page|

                # 検索開始インデックス
                start = (request_num % REQUEST_NUM_PER_KEYWORD) * (FETCH_NUM_PER_REQUEST * REQUESTABLE_NUM_PER_INSTANCE)
                start = start + page * 10

                # 検索URL
                url = "http://www.google.co.jp/search?q=#{URI.encode(keyword[:name])}&num=10&start=#{start}"

                html  = open(url, "User-Agent" => "User-Agent: #{USER_AGENT}", proxy: proxy_url){|f| f.read }
                doc = Nokogiri::HTML.parse(html, nil, nil)
                doc.xpath("//ol/li[@class='g']").each_with_index do |li, i|
                  rank  = start + i + 1
                  cite  = li.xpath("div//cite").to_s.gsub(/<.*?>/, "")
                  p "[#{rank}] #{cite}, #{keyword[:url]}"
                  Ranking.create(keyword_id: keyword[:id], number: rank) if cite.match /#{keyword[:url]}/
                end
              end
            end
          end
        end
        threads.each{ |t| t.join }
        ThreadsWait.new(*threads)

        p "thread finished"
      end
    end

    # 全てのタスクが終了したらEC2インスタンスを全停止する(無駄な料金を発生させないため)
    instances.each do |id|
      Aws::EC2::Resource.new.instance(id).stop
    end

    p "Crawling finished. Spent time: #{result}s"

  end

end