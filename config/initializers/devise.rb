# frozen_string_literal: true

Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  config.omniauth :facebook, "538751119984524", "8f939dbb1d710de3632051cfb5af6fe2", callback_url: "http://localhost:3000/users/auth/facebook/callback"
  # Rails.application.config.middleware.use OmniAuth::Builder do
  #   provider :facebook, ENV['538751119984524'], ENV['8f939dbb1d710de3632051cfb5af6fe2'], scope: 'email'
  # end
end
