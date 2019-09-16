class ConfirmPresenter < ShortAddressPresenter
  attr_reader :order, :coupon
  DONE_STEP = 4

  def initialize(order, coupon, credit_card)
    @order = order
    @credit_card = credit_card
    @coupon = coupon
  end

  def checkout_step
    :confirm
  end

  def payment_info_card_number
    '**** ' * 3 + @credit_card.number.last(4)
  end

  def expiry_date
    @credit_card.expiry_date.first(3) + '20' + @credit_card.expiry_date.last(2)
  end
end
