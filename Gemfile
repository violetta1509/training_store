source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'pagy', '~> 2.0.0'
gem 'devise', '~> 4.6.1'
gem 'omniauth-facebook', '~> 5.0.0'
gem 'aasm', '~> 5.0.1'
gem 'draper', '~> 3.0.1'
gem "font-awesome-rails"
gem 'simple_form', '~> 4.0.1'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5.2.0'
gem 'jbuilder', '~> 2.5'
gem "haml-rails", "~> 1.0"
gem 'presenter-rails', '~> 1.0.0'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'webpacker', '~> 4.x'
gem 'faker', '~> 1.9.3', require: false
gem 'carrierwave', '~> 1.0'
gem 'mini_magick', '~> 4.9.3'

# gem 'yui-compressor'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'pry'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '~> 0.71.0', require: false
  gem 'rubocop-rspec', '~> 1.33.0', require: false
  gem 'rubocop-rails'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'simplecov', '~> 0.16.1'
  gem 'factory_bot_rails', '~> 5.0.1'
  gem 'rails-controller-testing', '~> 1.0.4'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
