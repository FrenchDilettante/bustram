require 'capistrano/bundler'
require 'capistrano/bower'

lock '3.2.1'

set :application, 'bustram'
set :bower_flags, '--quiet --config.interactive=false'
set :bower_roles, :web
set :repo_url, 'git@github.com:manudwarf/bustram.git'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

end
