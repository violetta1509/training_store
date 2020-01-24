require 'capybara/rails'
require 'webdrivers/chromedriver'

Capybara.default_max_wait_time = 10
Capybara.server = :puma
Capybara.javascript_driver = :chrome
Capybara.default_driver = :chrome

logging_preferences = { browser: 'ALL' }

Capybara.register_driver :chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: logging_preferences)
  
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end
# Capybara.register_driver :headless_chrome do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: { args: %w(headless disable-gpu) },
#     loggingPrefs: logging_preferences
#   )
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :chrome,
#     desired_capabilities: capabilities
#   )
# end