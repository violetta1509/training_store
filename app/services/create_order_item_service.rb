class CreateOrderItemService
  def call(order, params)
    OrderItem.create(order_id: order.id, book_id: params[:book_id].to_i, quantity: params[:quantity].to_i) if order
  end
end
