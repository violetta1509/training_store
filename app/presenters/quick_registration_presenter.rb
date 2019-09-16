class QuickRegistrationPresenter
  CHECKOUT_STEP = 'quick_registration'.freeze

  def generated_password
    @generated_password ||= SecureRandom.base64(10)
  end

  def new_user
    User.new
  end
end
