class OrdersQuery
  FILTERS = {
    default: 'All orders',
    in_progress: 'In progress',
    processing: 'Processing',
    shipped: 'Shipped',
    delivered: 'Delivered',
    canceled: 'Canceled'
  }.freeze

  def initialize(user)
    @orders = user.orders
  end

  def orders_sort(filter)
    FILTERS.include?(FILTERS.key(filter)) ? @orders.public_send(FILTERS.key(filter)) : @orders
  end
end
