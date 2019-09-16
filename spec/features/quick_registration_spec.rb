describe 'the quick signup process', type: :feature do
  let!(:delivery_service) { create(:delivery_service) }
  let!(:user) { create(:user) }
  it 'success signs up' do
    visit '/checkout_step'
    fill_in 'quick_registration_email', with: FFaker::Internet.email
    click_button(I18n.t(:continue_button))
    expect(page.current_path).to eq books_path
  end

  it 'failed signs up' do
    visit '/checkout_step'
    fill_in 'quick_registration_email', with: user.email
    click_button(I18n.t(:continue_button))
    expect(page).to have_content I18n.t('registrations.can_not_use_account')
  end
end
