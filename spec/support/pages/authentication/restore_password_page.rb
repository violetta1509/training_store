class RestorePasswordPage < BasePage
  set_url '/users/password/new'

  element :forget_pass_title, 'h3.general-login-title'
  element :email, '#user_email'
  element :send_button, '[name="commit"]'
end
