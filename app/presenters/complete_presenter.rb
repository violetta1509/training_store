class CompletePresenter < ShortAddressPresenter
  attr_reader :order, :coupon

  DONE_STEP = 5

  def initialize(order, coupon)
    @order = order
    @coupon = coupon
  end

  def checkout_step
    :complete
  end
end
