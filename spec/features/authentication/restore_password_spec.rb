RSpec.describe 'RestorePassword' do

  let(:sign_in_page) { SignInPage.new }
  let(:restore_password_page) { RestorePasswordPage.new }

  let!(:user) { create(:user) }
  
  before { sign_in_page.load }

  context 'restore password' do
    it 'sends link to restore password' do
      sign_in_page.forgot_password_link.click

      expect(restore_password_page).to be_displayed
      expect(restore_password_page.forget_pass_title.text).to include('Forgot your password?')
      
      restore_password_page.email.set(user.email)
      restore_password_page.send_button.click

      expect(page).to have_current_path('/users/sign_in')
      expect(sign_in_page.success_flash.text).to eq('You will receive an email with instructions on how to reset your password in a few minutes.')
    end
  end
end