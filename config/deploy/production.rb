role :app, %w{seogazer}
role :web, %w{seogazer}
role :db,  %w{seogazer}

set :stage, :production
set :rails_env, :production

set :deploy_to, '/home/ec2-user/seogazer'

set :default_env, {
  rbenv_root: "/home/ec2-user/.rbenv",
  path: "/home/ec2-user/.rbenv/shims:/home/ec2-user/.rbenv/bin:$PATH",
}
