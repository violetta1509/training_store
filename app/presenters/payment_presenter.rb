class PaymentPresenter < SummaryPresenter
  attr_reader :order, :coupon
  DONE_STEP = 3

  def initialize(order, coupon, response = nil)
    @response_errors = response
    @order = order
    @coupon = coupon
  end

  def checkout_step
    :payment
  end

  def form
    @response_errors || valid_data_form
  end

  def valid_data_form
    @order.credit_card || CreditCard.new
  end
end
