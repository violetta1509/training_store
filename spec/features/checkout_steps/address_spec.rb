describe 'the address fields', type: :feature do
  let!(:user_billing_address) { create(:user_billing_address) }
  let(:user) { user_billing_address.addressable }
  let(:billing_arrtibutes) { FactoryBot.attributes_for(:user_billing_address) }
  let(:zip_with_wrong_length) { 12331234 }
  let(:country_from_list) { 'UK' }

  before do
    user.orders << create(:order, :with_order_items, user: user)
    login_as user, scope: :user
  end


  it 'fill billing address' do
    visit '/checkout_step'
    within('#billing_form') do
      fill_in I18n.t('settings.first_name'), with: billing_arrtibutes[:first_name]
      fill_in I18n.t('settings.last_name'), with: billing_arrtibutes[:last_name]
      fill_in I18n.t('settings.adress_area'), with: billing_arrtibutes[:street_address]
      fill_in I18n.t('settings.city'), with: billing_arrtibutes[:city]
      fill_in I18n.t('settings.zip'), with: billing_arrtibutes[:zip]
      page.select country_from_list, from: I18n.t('settings.country')
      fill_in I18n.t('settings.phone'), with: billing_arrtibutes[:phone]
    end
    first('.fa-check').click
    click_button(I18n.t('checkout.button'))
    expect(page).to have_content I18n.t('checkout.delivery.delivery_title')
    expect(page).to have_current_path('/checkout_step')
  end

  it 'fill billing address with mistakes' do
    visit '/checkout_step'
    within('#billing_form') do
      fill_in I18n.t('settings.first_name'), with: billing_arrtibutes[:first_name]
      fill_in I18n.t('settings.last_name'), with: billing_arrtibutes[:last_name]
      fill_in I18n.t('settings.adress_area'), with: billing_arrtibutes[:street_address]
      fill_in I18n.t('settings.city'), with: billing_arrtibutes[:city]
      fill_in I18n.t('settings.zip'), with: zip_with_wrong_length
      page.select country_from_list, from: I18n.t('settings.country')
      fill_in I18n.t('settings.phone'), with: billing_arrtibutes[:phone]
    end
    click_button(I18n.t('checkout.button'))
    expect(page).to have_content I18n.t('forms.wrong_zip_length')
  end

  it 'when empty fields' do
    visit '/checkout_step'
    within('#billing_form') do
      fill_in I18n.t('settings.zip'), with: zip_with_wrong_length
    end
    click_button(I18n.t('checkout.button'))
    expect(page).to have_content I18n.t('forms.wrong_zip_length')
    expect(page).to have_content I18n.t('forms.empty_last_name')
    expect(page).to have_content I18n.t('forms.empty_first_name')
    expect(page).to have_content I18n.t('forms.epmty_city')
    expect(page).to have_content I18n.t('forms.empty_country')
    expect(page).to have_content I18n.t('forms.empty_address')
    expect(page).to have_content I18n.t('forms.epmty_phone')
  end

  it 'when user have address' do
    visit '/checkout_step'
    expect(page).to have_field('order[billing_address][first_name]', with: user_billing_address.first_name)
    expect(page).to have_field('order[billing_address][last_name]', with: user_billing_address.last_name)
    expect(page).to have_field('order[billing_address][address]', with: user_billing_address.address)
    expect(page).to have_field('order[billing_address][city]', with: user_billing_address.city)
    expect(page).to have_field('order[billing_address][zip]', with: user_billing_address.zip)
    expect(page).to have_field('order[billing_address][country]', with: user_billing_address.country)
    expect(page).to have_field('order[billing_address][phone]', with: user_billing_address.phone)
  end
end
