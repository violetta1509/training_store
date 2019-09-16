class CheckoutShowService < CheckoutStepService
  def initialize(user, order, params)
    @user = user
    @order = order
    @params = params
  end

  def call
    return AddressPresenter.new(@user, @order, @order.coupon) if address?
    return DeliveryPresenter.new(@order, @order.coupon) if delivery?
    return PaymentPresenter.new(@order, @order.coupon) if payment?
    return ConfirmPresenter.new(@order, @order.coupon, @order.credit_card) if @order.confirm?

    complete_order if @order.complete?
  end

  private

  def complete_order
    @order.to_processing! if @order.may_to_processing?
    CompletePresenter.new(@order, @order.coupon)
  end

  def can_edit?(step)
    @order.confirm? && @params[:step] == step
  end

  def address?
    @order.address? || can_edit?(VIEW_STEPS[:address])
  end

  def delivery?
    @order.delivery? || can_edit?(VIEW_STEPS[:delivery])
  end

  def payment?
    @order.payment? || can_edit?(VIEW_STEPS[:payment])
  end
end
