require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start do
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/decorators/order_item_decorator.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/uploaders/image_uploader.rb'
  add_filter 'app/services/utils/sekrets_service.rb'
  add_filter 'app/admin'
end

require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include LoginUser
  config.include AuthHash

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
