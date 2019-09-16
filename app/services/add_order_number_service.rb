class AddOrderNumberService
  def call(order)
    add_order_number(order)
  end

  private

  def add_order_number(order)
    order.update(number: '#R' + DateTime.current.strftime('%Q')) unless order.number
  end
end
