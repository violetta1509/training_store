class OrdersController < ApplicationController
  authorize_resource

  def index
    filter = params[:filter]
    @presenter = OrderPresenter.new(OrdersQuery.new(current_user).orders_sort(filter), filter)
  end
end
