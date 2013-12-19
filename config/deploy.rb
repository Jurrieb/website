set :rbenv_ruby, "2.0.0-p353"
set :application, 'website'
set :repo_url, 'git@github.com:Jurrieb/website.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :scm, :git

set :format, :pretty
set :log_level, :info

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, { path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }
set :keep_releases, 5

#set :normalize_asset_timestamps, false
set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}

set :migration_role, 'postgres' # Defaults to 'db'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do

  end

  # after "deploy", "deploy:migrate"

  after :finishing, 'deploy:cleanup'
end

namespace :deploy do
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end
