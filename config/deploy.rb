# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "bbq2"
set :repo_url, "git@github.com:asromanychev/mik22.git"
# Also works with non-github repos, I roll my own gitolite server
set :deploy_to, "/home/deploy/#{fetch :application}"
set :rbenv_prefix, '/usr/bin/rbenv exec' # Cf issue: https://github.com/capistrano/rbenv/issues/96

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

namespace :deploy do
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
  #
  # task :restart do
  # end

  namespace :assets do
    Rake::Task['deploy:assets:precompile'].clear_actions

    desc "Precompile assets on local machine and upload them to the server."
    task :precompile do
      run_locally do
        execute "mkdir -p ./public/assets"
        execute "rm -r ./public/assets"
      end

      run_locally do
        execute "RAILS_ENV=production bundle exec rake assets:precompile"
        execute 'rm ./tmp/assets.tar.gz' rescue nil
        execute 'tar -C ./public -zcvf ./tmp/assets.tar.gz assets'
      end

      on roles(:web) do
        within release_path do
          public_path = "#{release_path}/public"

          upload! "./tmp/assets.tar.gz", public_path

          execute "tar -C #{public_path} -zxvf #{public_path}/assets.tar.gz"
        end
      end

      run_locally do
        execute "rm -r ./public/assets"
        execute 'rm ./tmp/assets.tar.gz' rescue nil
      end
    end
  end
end