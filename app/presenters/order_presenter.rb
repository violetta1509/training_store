class OrderPresenter < ShortAddressPresenter
  attr_reader :orders, :filter

  def initialize(orders, filter)
    @orders = orders
    @filter = OrdersQuery::FILTERS.values.include?(filter) ? filter : OrdersQuery::FILTERS[:default]
  end

  def status(order)
    order.status.humanize
  end
end
