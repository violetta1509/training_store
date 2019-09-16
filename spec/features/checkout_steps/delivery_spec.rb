describe 'the delivery page', type: :feature do
  let!(:user_billing_address) { create(:user_billing_address) }
  let(:user) { user_billing_address.addressable }

  before do
    user.orders << create(:order, :with_order_items, user: user, checkout: 'delivery')
    login_as user, scope: :user
  end

  it 'choose a delivery service' do
    visit '/checkout_step'
    click_button(I18n.t('checkout.button'))
    expect(page).to have_content I18n.t('checkout.card_title')
    expect(page).to have_css('.font-18', text: I18n.t('price', price: DeliveryService.all.first.price + user.orders.first.total))
  end
end
