role :app, %w{toolbox.candypot.jp}
role :web, %w{toolbox.candypot.jp}
role :db,  %w{toolbox.candypot.jp}

set :stage, :production
set :rails_env, :production

set :deploy_to, '/home/ec2-user/cdpseogazer'

set :unicorn_bin, 'unicorn_rails'
set :unicorn_options, "--path /cdpseogazer"
set :bundle_gemfile, nil

set :default_env, {
  rbenv_root: "/home/ec2-user/.rbenv",
  path: "/home/ec2-user/.rbenv/shims:/home/ec2-user/.rbenv/bin:$PATH",
}
