class OrderItemsController < ApplicationController
  def create
    order_item = CreateOrderItemService.new.call(get_current_order, order_item_params)
    order_item ? set_flash(order_item) : save_guest

    redirect_to books_path
  end

  private

  def order_item_params
    params.permit(:quantity, :book_id)
  end

  def set_flash(order_item)
    order_item.save ? flash[:success] = t(:'order_items.added_to_card') : flash[:danger] = t(:'order_items.disabled_add_to_card')
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
