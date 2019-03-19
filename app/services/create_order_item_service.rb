require 'pry'
class CreateOrderItemService
  def initialize(order, params)
    @order = order
    @book_id = params[:book_id].to_i
    @quantity = params[:quantity].to_i
  end

  def call
    OrderItem.create(order_id: @order.id, book_id: @book_id, quantity: @quantity) if @order
  end
end
