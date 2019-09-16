class ConfirmOrResetCouponService
  def call(order, coupon)
    order.total > coupon.value ? confirm_coupon(order, coupon) : reset_coupon(order)
  end

  private

  def confirm_coupon(order, coupon)
    new_total = order.total - coupon.value
    order.update(total: new_total)
  end

  def reset_coupon(order)
    Coupon.find_by(id: order.coupon.id).update(order_id: nil, active: true)
    order.update(coupon_id: nil)
  end
end
