require_relative 'boot'
require "sprockets/railtie"
require 'rails/all'
require 'presenter'
require_relative 'secrets_loader'

Bundler.require(*Rails.groups)

module BookStore
  class Application < Rails::Application
    config.before_configuration { SecretsLoader.new.call }
    config.load_defaults 5.2
    config.autoload_paths << Rails.root.join('app/presenters')
    config.assets.initialize_on_precompile = false
  end
end
