class HeaderPresenter < ApplicationPresenter
  def categories
    Category.all
  end

  def get_order_item_quantity(user)
    user.order.order_items.count
  end
end
