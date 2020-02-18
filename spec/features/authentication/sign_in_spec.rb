RSpec.describe 'SignIn' do
  
  let(:sign_in_page) { SignInPage.new }
  let(:home_page) { HomePage.new }

  let(:user) { create(:user) }

  before { sign_in_page.load }

  context 'when open page' do
    it { expect(sign_in_page).to be_displayed }
    it { expect(sign_in_page).to be_all_there }
    it { expect(sign_in_page.title).to eq('Bookstore') }
  end

  context 'with correct email and password' do
    it 'user logs in' do
      sign_in_page.email.set(user.email)
      sign_in_page.password.set(user.password)
      sign_in_page.login_button.click

      expect(home_page).to be_displayed
      expect(home_page.success_flash.text).to eq(I18n.t('devise.sessions.signed_in'))
      expect(home_page.user_email.text).to eq(user.email)
      expect(home_page).to have_no_sign_up_link
      expect(home_page).to have_no_login_link
    end
  end
end
