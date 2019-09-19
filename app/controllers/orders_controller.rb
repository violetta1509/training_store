class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    filter = params[:filter]
    @presenter = OrderPresenter.new(OrdersQuery.new(current_user).orders_sort(filter), filter)
  end

  def show
    @presenter = ConfirmPresenter.new(@order, @order.coupon, @order.credit_card)
  end
end
