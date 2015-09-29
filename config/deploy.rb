set :application, "donuts-tech-blog"
set :repo_url, 'git@github.com:Iwark/donuts-tech-blog.git'

set :scm, :git

set :rbenv_ruby, '2.2.2'

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets public/uploads}

set :default_stage, "production"

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :bundle_env_variables, { 'NOKOGIRI_USE_SYSTEM_LIBRARIES' => 1 }

# set :linked_dirs, (fetch(:linked_dirs) + ['tmp/pids'])

set :unicorn_rack_env, "production"
set :unicorn_config_path, 'config/unicorn.rb'

namespace :deploy do

  # Compresses all .js and .css files under the assets path.
  # 
  # It is important that we execute this after :normalize_assets because
  # ngx_http_gzip_static_module recommends that compressed and uncompressed
  # variants have the same mtime. Note that gzip(1) sets the mtime of the
  # compressed file after the original one automatically.
  # after :normalize_assets, :gzip_assets do
  #   on release_roles(fetch(:assets_roles)) do
  #     assets_path = release_path.join('public', fetch(:assets_prefix))
  #     within assets_path do
  #       execute :find, ". \\( -name '*.js' -o -name '*.css' \\) -exec test ! -e {}.gz \\; -print0 | xargs -r -P8 -0 gzip --keep --best --quiet"
  #     end
  #   end
  # end

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'cache:clear'
        end
      end
    end
  end

end
