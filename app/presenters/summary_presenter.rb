class SummaryPresenter < StatusLinePresenter
  def subtotal_order
    @order.total
  end

  def coupon_order
    @coupon ? @coupon.value : 0
  end

  def total_order
    subtotal_order > coupon_order ? (subtotal_order - coupon_order).round(2) : subtotal_order
  end

  def right_position?(current_order)
    current_order.confirm? || @order.complete?
  end
end
