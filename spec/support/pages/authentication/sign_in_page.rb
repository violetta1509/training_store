class SignInPage < BasePage
  set_url '/users/sign_in'

  element :email, '#user_email'
  element :password, '#user_password'
  element :login_button, '[name="commit"]'
  element :forgot_password_link, 'a[href="/users/password/new"]'
end
