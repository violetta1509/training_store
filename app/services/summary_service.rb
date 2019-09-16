class SummaryService
  def call(current_user, guest_items, current_coupon, current_order)
    current_user ? user_summary(current_order) : guest_summary(guest_items, current_coupon, current_user)
  end

  private

  def user_summary(current_order)
    coupon_value = current_order.coupon ? current_order.coupon.value : 0
    subtotal = current_order.total
    { coupon: coupon_value, subtotal: subtotal, total: total(subtotal, coupon_value, current_order) }
  end

  def guest_summary(guest_items, current_coupon, current_user)
    coupon_value = Coupon.find_by(id: current_coupon, active: true, order_id: nil)&.value || 0
    subtotal = summary_subtotal(current_user, guest_items).round(2)
    { coupon: coupon_value, subtotal: subtotal, total: total(subtotal, coupon_value) }
  end

  def summary_subtotal(current_user, guest_items)
    OrderItemsService.new(current_user, guest_items).call.inject(0) { |total, (book, num)| total + (book.price * num.to_i) }
  end

  def total(subtotal, coupon_value, order = nil)
    total = subtotal > coupon_value ? (subtotal - coupon_value).round(2) : subtotal
    if order
      return (total + order.delivery_service.price).round(2) if order.delivery_service
    end
    total
  end
end
