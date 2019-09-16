describe 'the signin process', type: :feature do
  let!(:user) { create(:user, password: 'Faker121word') }

  it 'signs me in' do
    visit '/users/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: ''
    click_button(I18n.t(:enter))
    expect(page).not_to have_content I18n.t('flash.confirm_registration')
  end
end
