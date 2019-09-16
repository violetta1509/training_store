describe 'the payment page', type: :feature do
  let(:user) { create(:user, :with_order) }
  let(:order) { user.orders.in_progress.first }
  let!(:order_billing_address) { create(:order_billing_address, addressable: order) }
  let!(:order_shipping_address) { create(:order_shipping_address, addressable: order) }
  let!(:user_billing_address) { create(:user_billing_address, addressable: user) }
  let!(:user_shipping_address) { create(:user_shipping_address, addressable: user) }
  let(:credit_card) { create(:credit_card) }

  before do
    user.orders.first.to_delivery!
    user.orders.first.to_payment!
    login_as user, scope: :user
  end

  it 'when correct fill payment fields' do
    visit '/checkout_step'

    within('#new_credit_card') do
      fill_in I18n.t('checkout.payment.card_number'), with: credit_card.number
      fill_in I18n.t('checkout.payment.name'), with: credit_card.name
      fill_in I18n.t('checkout.payment.card_date'), with: credit_card.expiry_date
      fill_in I18n.t('checkout.payment.cvv'), with: credit_card.cvv
    end
    click_button('Save and Continue')
    expect(page).to have_content I18n.t('checkout.address.shipping_title')
    expect(page).to have_content I18n.t('checkout.address.billing_title')
    expect(page).to have_content I18n.t('checkout.confirm.shipments')
    expect(page).to have_content I18n.t('checkout.confirm.payment_info')
  end
  context 'when incorrect fill payment fields' do
    let(:number_error) { 'incorrect enter' }
    let(:name_error) { ' ' }
    let(:expiry_date_error) { '000000000000' }
    let(:сvv_error) { '12312312313' }

    it 'when incorrect fill payment fields' do
      visit '/checkout_step'

      within('#new_credit_card') do
        fill_in I18n.t('checkout.payment.card_number'), with: number_error
        fill_in I18n.t('checkout.payment.name'), with: name_error
        fill_in I18n.t('checkout.payment.card_date'), with: expiry_date_error
        fill_in I18n.t('checkout.payment.cvv'), with: сvv_error
      end
      click_button('Save and Continue')
      expect(page).to have_content I18n.t('forms.wrong_format_date_card')
      expect(page).to have_content I18n.t('checkout.payment.error_card_number')
      expect(page).to have_content I18n.t('checkout.payment.error_field_can_not_be_empty')
      expect(page).to have_content I18n.t('forms.expiry_date')
      expect(page).to have_content I18n.t('checkout.payment.error_cvv')
    end
  end

  context 'when the user bypassed the frontal check expired card' do
    let(:expired_date) { '12/18' }

    it 'expired date of card' do
      visit '/checkout_step'

      within('#new_credit_card') do
        fill_in I18n.t('checkout.payment.card_number'), with: credit_card.number
        fill_in I18n.t('checkout.payment.name'), with: credit_card.name
        fill_in I18n.t('checkout.payment.card_date'), with: expired_date
        fill_in I18n.t('checkout.payment.cvv'), with: credit_card.cvv
      end
      click_button(I18n.t('checkout.button'))
      expect(page).to have_content I18n.t('checkout.payment.error_expiry_date')
    end
  end
end
