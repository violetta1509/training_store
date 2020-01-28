RSpec.describe 'SignUp' do
  let(:signup_page) { SignUp.new }
 
  # Positive cases
  context 'fill sign up form' do
    it 'clicks facebook icon' do
      signup_page.load
      signup_page.facebook_icon.click
      current_path.should == '/users/auth/facebook'
    end
  
    it 'signs up successfully' do
      signup_page.load
      signup_page.email_field.set 'vasya@gmail.com'
      sleep(2)
      signup_page.password_field.set '12345678'
      sleep(2)
      signup_page.password_confirmation_field.set '12345678'
      sleep(2)
      signup_page.form_submit.click
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end 

    # Negative cases
    it 'signs up with empty fields' do
      signup_page.load
      signup_page.form_submit.click
      expect(signup_page).to have_content('Email can\'t be blank and Email is invalid')
      expect(signup_page).to have_content('Password can\'t be blank')
    end

     it 'signs up with wrong email' do
      signup_page.load
      signup_page.email_field.set 'vasyagmail.com'
      sleep(2)
      signup_page.password_field.set '12345678'
      sleep(2)
      signup_page.password_confirmation_field.set '12345678'
      sleep(2)
      signup_page.form_submit.click
      expect(page).to have_content('Email is invalid')
    end 

    it 'signs up with wrong password' do
      signup_page.load
      signup_page.email_field.set 'vasya@gmail.com'
      sleep(2)
      signup_page.password_field.set '12345'
      sleep(2)
      signup_page.password_confirmation_field.set '12345'
      sleep(2)
      signup_page.form_submit.click
      expect(page).to have_content('Password is too short (minimum is 6 characters')
    end 

    it 'signs up with wrong password confirmation' do
      signup_page.load
      signup_page.email_field.set 'vasya@gmail.com'
      sleep(2)
      signup_page.password_field.set '12345678'
      sleep(2)
      signup_page.password_confirmation_field.set '1234567'
      sleep(2)
      signup_page.form_submit.click
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end 
  end
end