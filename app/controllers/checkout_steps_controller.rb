class CheckoutStepsController < ApplicationController
  def show
    return quick_registration unless current_user

    redirect_to(books_path) && return if current_order.order_items.empty?
    @presenter = CheckoutShowService.new(current_user, current_order, params).call
    render @presenter.checkout_step
  end

  def update
    checkout = UpdateCheckoutService.new.call(current_user, current_order, params)
    if errors?(checkout)
      assiign_presenter(checkout)

      return render @presenter.checkout_step
    end

    redirect_to(checkout_step_path)
  end

  private

  def errors?(checkout)
    checkout.is_a?(Array) ? checkout.map { |checkout_step| checkout_step.errors.any? }.include?(true) : checkout.errors.any?
  end

  def assiign_presenter(checkout)
    @presenter = checkout.is_a?(Array) ? address_with_errors(checkout) : payment_with_errors(checkout)
  end

  def payment_with_errors(checkout)
    PaymentPresenter.new(current_order, current_order.coupon, checkout)
  end

  def address_with_errors(checkout)
    AddressPresenter.new(current_user, current_order, current_order.coupon,
                         checkout.first, checkout.last)
  end

  def quick_registration
    @presenter = QuickRegistrationPresenter.new
    render QuickRegistrationPresenter::CHECKOUT_STEP
  end
end
