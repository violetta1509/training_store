describe 'the complete template' do
  let(:order) { create(:order, :with_order_items, checkout: 'complete') }
  let(:user) { order.user }
  let!(:order_billing_address) { create(:order_billing_address, addressable: order) }
  let!(:order_shipping_address) { create(:order_shipping_address, addressable: order) }
  let!(:user_billing_address) { create(:user_billing_address, addressable: user) }
  let!(:user_shipping_address) { create(:user_shipping_address, addressable: user) }
  let!(:credit_card) { create(:credit_card, order: order) }

  before do
    login_as user, scope: :user
  end

  it 'user on complete template' do
    visit '/checkout_step'
    expect(page).to have_selector(:css, 'a[href="/books"]')
    expect(page).to have_content I18n.t('checkout.complete.thanks_for_order')
    expect(page).to have_content order.order_items.first.book.title
  end
end
