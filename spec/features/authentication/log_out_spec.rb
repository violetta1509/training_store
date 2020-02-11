RSpec.describe 'LogOut' do

  let(:sign_in_page) { SignInPage.new }
  let(:home_page) { HomePage.new }
  
  let(:user) { create(:user) }

  before { sign_in_page.load }

  context 'from the home page' do
    it 'user logs out' do
      sign_in_page.email.set(user.email)
      sign_in_page.password.set(user.password)
      sign_in_page.login_button.click

      expect(home_page).to be_displayed
      expect(home_page.success_flash.text).to eq('Signed in successfully.')
      expect(home_page.user_email.text).to eq(user.email)
      expect(home_page).to have_no_sign_up_link
      expect(home_page).to have_no_login_link
      
      home_page.user_email.click
      home_page.logout.click

      expect(home_page.success_flash.text).to eq('Signed out successfully.')
      expect(home_page).to have_no_user_email
    end
  end
end