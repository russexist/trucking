# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application,     'trucking'
set :user,            'deployer'
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :repo_url,        'git@github.com:russexist/trucking.git'

set :passenger_restart_with_touch, true

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
  'vendor/bundle', 'public/system', 'public/uploads'
