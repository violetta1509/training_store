RSpec.describe 'SignUp' do
  
  let(:sign_up_page) { SignUpPage.new }
  let(:home_page) { HomePage.new }

  let(:user_email) { FFaker::Internet.email }
  let(:user_password) { FFaker::Internet.password }

  before { sign_up_page.load }

  context 'when open page' do
    it { expect(sign_up_page).to be_displayed }
    it { expect(sign_up_page).to be_all_there }
    it { expect(sign_up_page.title).to eq('Bookstore') }
  end

  context 'with valid data' do
    it 'user signs up' do
      sign_up_page.email.set(user_email)
      sign_up_page.password.set(user_password)
      sign_up_page.password_confirmation.set(user_password)
      sign_up_page.sign_up_button.click

      expect(home_page).to be_displayed
      expect(home_page.success_flash.text).to eq('Welcome! You have signed up successfully.')
    end
  end
end
