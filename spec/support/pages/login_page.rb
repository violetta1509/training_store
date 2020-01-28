class LogIn < BasePage
  set_url '/users/sign_in'
  
  element :facebook_icon, '.fa-facebook-official'
  element :email_field, '#user_email'
  element :password_field, '#user_password'
  element :submit_button, '[name="commit"]'
  element :signup_link, '.in-gold-500[href="/users/sign_up"]'
  element :forgot_password_link, 'a[href="/users/password/new"]'
end