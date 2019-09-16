class CartsController < ApplicationController
  attr_reader :items, :order
  def show
    @items = OrderItemsService.new(current_user, session[:guest_items]).call
    @coupon = Coupon.new
  end
end
