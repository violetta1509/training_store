class UpdateCheckoutService < CheckoutStepService
  def call(_user, order, params)
    return add_address(params, order) if params.include?('order')
    return assign_deliver(order, params) if params.include?('delivery')
    return assign_credit_card(order, params[:credit_card]) if params.include?('credit_card')
    return assign_credit_card(order, params[:credit_card_form]) if params.include?('credit_card_form')

    order_to_complete(order) if order.may_to_complete?
  end

  private

  def order_to_complete(order)
    AddOrderNumberService.new.call(order)
    ConfirmOrResetCouponService.new.call(order, order.coupon) if order.coupon
    order.to_complete!
    OrderMailer.order_confirmation(order).deliver_now
    order
  end

  def add_address(params, order)
    new_address = UpdateAddressService.new.call(params[:order], order)
    change_order_checkout(order, VIEW_STEPS[:delivery]) unless address_error?(new_address)
    new_address
  end

  def assign_deliver(order, params)
    update = order.update(delivery_service_id: params['delivery']['deliver_id'])
    change_order_checkout(order, VIEW_STEPS[:payment]) if update
    order
  end

  def assign_credit_card(order, params)
    credit_card = CreditCardForm.new(card_params(params))
    change_order_checkout(order, VIEW_STEPS[:confirm]) if credit_card.save(order)
    credit_card
  end

  def address_error?(new_address)
    new_address.first.errors.present? || new_address.last.errors.present?
  end

  def change_order_checkout(order, state)
    order.public_send('to_' + state + '!') if order.public_send('may_to_' + state + '?')
  end

  def card_params(params)
    params.permit(:number, :cvv, :name, :expiry_date)
  end
end
