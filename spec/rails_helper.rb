require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

#require 'rspec/rails'
#Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

require 'rspec/rails'
require File.expand_path('support/pages/base_page', __dir__)
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end


