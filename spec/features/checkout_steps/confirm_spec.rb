describe 'the complete template', type: :feature do
  let(:user) { create(:user, :with_order) }
  let(:order) { user.orders.in_progress.first }
  let!(:order_billing_address) { create(:order_billing_address, addressable: order) }
  let!(:order_shipping_address) { create(:order_shipping_address, addressable: order) }
  let!(:user_billing_address) { create(:user_billing_address, addressable: user) }
  let!(:user_shipping_address) { create(:user_shipping_address, addressable: user) }
  let!(:credit_card) { create(:credit_card, order: order) }

  before do
    user.orders.first.update(checkout: 'confirm')
    login_as user, scope: :user
  end

  it 'user move to change address' do
    visit '/checkout_step'
    click_link('shipping')
    expect(page).to have_content I18n.t('settings.billing_address')
    expect(page).to have_content I18n.t('settings.shipping_address')
    expect(page).to have_content I18n.t('checkout.address.require_filds')
  end

  it 'user move to change address' do
    visit '/checkout_step'
    click_link('billing')
    expect(page).to have_content I18n.t('settings.billing_address')
    expect(page).to have_content I18n.t('settings.shipping_address')
    expect(page).to have_content I18n.t('checkout.address.require_filds')
  end

  it 'user move to change shipments' do
    visit '/checkout_step'
    click_link('shipments')
    expect(page).to have_content I18n.t('checkout.delivery.delivery_title')
    expect(page).to have_content I18n.t('checkout.delivery.method_column')
    expect(page).to have_content I18n.t('checkout.delivery.days_column')
    expect(page).to have_content I18n.t('checkout.delivery.price_column')
  end

  it 'user move to change payment' do
    visit '/checkout_step'
    click_link('payment')
    expect(page).to have_content I18n.t('checkout.card_title')
    expect(page).to have_content I18n.t('checkout.payment.card_number')
    expect(page).to have_content I18n.t('checkout.payment.name')
    expect(page).to have_content I18n.t('checkout.payment.card_number')
    expect(page).to have_content I18n.t('checkout.payment.card_date')
  end
end
