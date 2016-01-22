# config valid only for current version of Capistrano
lock '3.4.0'

require 'capistrano-db-tasks'

set :application, 'forst-drunken-ibex'
set :repo_url, 'git@github.com:curcumalabs/forst-drunken-ibex.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/mnt/hosting/sites/forst/forst-drunken-ibex'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/secrets.yml',
  '.rbenv-vars'
)

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'public/spree'
)

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)}"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :passenger_restart_with_touch, true

set :slack_webhook, "https://hooks.slack.com/services/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"

# Default value for keep_releases is 5
# set :keep_releases, 5

# Capistrano db-tasks settings

# if you want to remove the local dump file after loading
set :db_local_clean, true

# if you want to remove the dump file from the server after downloading
set :db_remote_clean, true

# if you want to use local db config (config/database.yml)
set :db_use_local_config, true

# If you want to import assets, you can change default asset dir (default = system)
# This directory must be in your shared directory on the server
set :assets_dir, %w(public/assets public/spree)

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
