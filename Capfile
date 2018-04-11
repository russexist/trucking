# frozen_string_literal: true

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
require 'capistrano/rbenv'
require 'capistrano/rails'
require 'capistrano/passenger'

install_plugin Capistrano::SCM::Git

set :rbenv_type, :user
set :rbenv_ruby, '2.5.0'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
