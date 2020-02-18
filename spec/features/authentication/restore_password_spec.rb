RSpec.describe 'RestorePassword' do

  let(:sign_in_page) { SignInPage.new }
  let(:restore_password_page) { RestorePasswordPage.new }

  let!(:user) { create(:user) }
  
  before { sign_in_page.load }

  context 'restore password' do
    it 'sends link to restore password' do
      sign_in_page.forgot_password_link.click

      expect(restore_password_page).to be_displayed
      expect(restore_password_page.forget_pass_title.text).to include(I18n.t('devise.fogot_password'))
      
      restore_password_page.email.set(user.email)
      restore_password_page.send_button.click

      expect(page).to have_current_path('/users/sign_in')
      expect(sign_in_page.success_flash.text).to eq(I18n.t('devise.passwords.send_instructions'))
    end

    it 'with empty email field' do
      sign_in_page.forgot_password_link.click

      expect(restore_password_page).to be_displayed
      expect(restore_password_page.forget_pass_title.text).to include(I18n.t('devise.fogot_password'))
      
      restore_password_page.send_button.click

      expect(restore_password_page.error_flash.text).to eq(I18n.t('simple_form.error_notification.default_message'))
      expect(restore_password_page.error_message.text).to eq('Email can\'t be blank')
    end
  end
end