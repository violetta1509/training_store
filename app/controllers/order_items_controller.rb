require 'pry'
class OrderItemsController < ApplicationController
  def create
    order_item = CreateOrderItemService.new(get_current_order, params.permit(:quantity, :book_id)).call
    order_item ? set_flash(order_item) : save_guest

    redirect_to books_path
  end

  def update
  end

  private

  def set_flash(order_item)
    order_item.save ? flash[:success] = 'Added to card' : flash[:danger] = 'Cann`t add to card'
  end

  def save_guest
    session[:guest] ||= []
    session[:guest] << { id: params[:book_id], quantity: params[:quantity] }
  end

  def get_current_order
    return unless user_signed_in?

    session[:order_id] = create_order.id unless session[:order_id]
    Order.find_by(id: session[:order_id])
  end

  def create_order
    Order.create(user_id: current_user.id)
  end
end
