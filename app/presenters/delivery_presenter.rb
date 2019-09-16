class DeliveryPresenter < SummaryPresenter
  attr_reader :order, :coupon
  DONE_STEP = 2

  def initialize(order, coupon)
    @order = order
    @coupon = coupon
  end

  def checkout_step
    :delivery
  end

  def current_delivery_service?(order, service)
    service.name == order.delivery_service.name
  end

  def delivery_services
    DeliveryService.all
  end
end
