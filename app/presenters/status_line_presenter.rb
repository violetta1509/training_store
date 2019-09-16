class StatusLinePresenter
  def need_divider?(index)
    index < CheckoutStepService::VIEW_STEPS.length
  end
end
