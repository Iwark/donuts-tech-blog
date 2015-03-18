role :app, %w{donuts-tech-blog}
role :web, %w{donuts-tech-blog}
role :db,  %w{donuts-tech-blog}

set :stage, :production
set :rails_env, :production

set :deploy_to, '/home/ec2-user/donuts-tech-blog'

set :default_env, {
  rbenv_root: "/home/ec2-user/.rbenv",
  path: "/home/ec2-user/.rbenv/shims:/home/ec2-user/.rbenv/bin:$PATH",
}
