require_relative 'boot'
require "sprockets/railtie"
require 'rails/all'
require 'presenter'

Bundler.require(*Rails.groups)

module BookStore
  class Application < Rails::Application
    config.load_defaults 5.2
    config.autoload_paths << Rails.root.join('app/presenters')

  end
end
