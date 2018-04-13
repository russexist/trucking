# frozen_string_literal: true

server ENV['SERVER_IP'], user: 'deployer', roles: %w[app db web]
