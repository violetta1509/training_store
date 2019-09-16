class ApplyCouponServise
  def call(coupon, current_order)
    use_coupon(current_order, coupon) if current_order.total > coupon.value
  end

  private

  def use_coupon(current_order, coupon)
    coupon.update(order_id: current_order.id, active: false) unless current_order.coupon
    current_order.update(coupon_id: coupon.id)
  end
end
