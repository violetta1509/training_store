class SignUp < BasePage
  set_url '/users/sign_up'
  
  element :facebook_icon, '.fa-facebook-official'
  element :email_field, '#user_email'
  element :password_field, '#user_password'
  element :password_confirmation_field, '#user_password_confirmation'
  element :form_submit, '[name="commit"]'
  element :login_link, 'a[href="/users/sign_in"]'
end