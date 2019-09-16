class AddressPresenter < SummaryPresenter
  attr_reader :order, :coupon

  DONE_STEP = 1

  def initialize(user, order, coupon, billing_errors = nil, shipping_errors = nil)
    @user = user
    @order = order
    @coupon = coupon
    @billing_errors = billing_errors
    @shipping_errors = shipping_errors
  end

  def checkout_step
    :address
  end

  def billing_address
    @billing_errors || form_with_data('billing_address')
  end

  def form_with_data(address)
    order_address(address) || address.camelize.constantize.new
  end

  def shipping_address
    @shipping_errors || form_with_data('shipping_address')
  end

  private

  def order_address(address)
    @order.public_send(address) || @user.public_send(address)
  end
end
