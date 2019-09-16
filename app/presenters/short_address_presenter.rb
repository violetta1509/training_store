class ShortAddressPresenter < SummaryPresenter
  def full_address(address)
    @order.public_send(address).first_name + ' ' + @order.public_send(address).last_name
  end

  def address(type)
    @order.public_send(type).address
  end

  def country(type)
    @order.public_send(type).country + ' ' + @order.public_send(type).zip
  end

  def city(type)
    @order.public_send(type).city
  end

  def order_items
    @order.order_items
  end

  def phone(type)
    @order.public_send(type).phone
  end
end
