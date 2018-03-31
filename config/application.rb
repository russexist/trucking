# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Trucking
  class Application < Rails::Application
    config.load_defaults 5.1

    config.i18n.available_locales = %i[en ru ua]
    config.i18n.default_locale = :ru

    config.time_zone = 'Europe/Kiev'
    config.active_record.default_timezone = :local
  end
end
