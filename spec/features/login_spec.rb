RSpec.describe 'LogIn' do
  let(:login_page) { LogIn.new }

  # Positive cases
  context 'fill login form' do
    it 'logs in existing user' do
    end

    it 'clicks forgot password link' do
      login_page.load
      login_page.forgot_password_link.click
      current_path.should == '/users/password/new'
    end

    it 'clicks sign up link' do
      login_page.load
      login_page.signup_link.click
      current_path.should == '/users/sign_up'
    end

    # Negative cases
    it 'logs in with empty fields' do
      login_page.load
      login_page.submit_button.click
      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
