RSpec.describe 'Settings' do
  
  let(:home_page) { HomePage.new }
  let(:settings_page) { SettingsPage.new }

  context "open settings page" do
    let!(:user) { create(:user) }

    before do
      login_as(user)
      home_page.load
    end

    it 'goes to settings page' do
      home_page.user_email.click
      home_page.settings.click

      expect(page).to have_current_path('/settings')
      expect(settings_page.settings_title.text).to include(I18n.t('settings.title'))
    end
  end

  context "add user's addresses" do
    let!(:user) { create(:user) }
    let(:address) { create(:address, addressable: user) }

    before do
      login_as(user)
      home_page.load
    end
    
    it 'add new billing address' do
      home_page.user_email.click
      home_page.settings.click
      settings_page.b_first_name.set(address.first_name)
      settings_page.b_last_name.set(address.last_name)
      settings_page.b_address.set(address.address)
      settings_page.b_city.set(address.city)
      settings_page.b_zip_code.set(address.zip)
      settings_page.b_country.click
      settings_page.b_first_country.click
      settings_page.b_phone.set(address.phone)
      settings_page.b_save_button.click

      expect(settings_page.b_first_name).to have_text('')
      expect(settings_page.b_last_name).to have_text('')
      expect(settings_page.b_address).to have_text('')
      expect(settings_page.b_city).to have_text('')
      expect(settings_page.b_zip_code).to have_text('')
      expect(settings_page.b_country).to have_text('')
      expect(settings_page.b_phone).to have_text('')
    end

    it 'add new shipping address' do
      home_page.user_email.click
      home_page.settings.click
      settings_page.sh_first_name.set(address.first_name)
      settings_page.sh_last_name.set(address.last_name)
      settings_page.sh_address.set(address.address)
      settings_page.sh_city.set(address.city)
      settings_page.sh_zip_code.set(address.zip)
      settings_page.sh_country.click
      settings_page.sh_first_country.click
      settings_page.sh_phone.set(address.phone)
      settings_page.sh_save_button.click

      expect(settings_page.sh_first_name).to have_text('')
      expect(settings_page.sh_last_name).to have_text('')
      expect(settings_page.sh_address).to have_text('')
      expect(settings_page.sh_city).to have_text('')
      expect(settings_page.sh_zip_code).to have_text('')
      expect(settings_page.sh_country).to have_text('')
      expect(settings_page.sh_phone).to have_text('')
    end
  end
end
