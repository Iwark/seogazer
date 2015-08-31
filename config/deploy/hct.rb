role :app, %w{toolbox.candypot.jp}
role :web, %w{toolbox.candypot.jp}
role :db,  %w{toolbox.candypot.jp}

set :stage, :production
set :rails_env, :production

set :deploy_to, '/home/ec2-user/hctseogazer'

set :unicorn_command, 'bundle exec unicoran_rails'
set :unicorn_options, "-path /hctseogazer"

set :default_env, {
  rbenv_root: "/home/ec2-user/.rbenv",
  path: "/home/ec2-user/.rbenv/shims:/home/ec2-user/.rbenv/bin:$PATH",
}
