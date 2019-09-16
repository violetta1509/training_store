class Users::RegistrationsController < Devise::RegistrationsController
  after_action :apply_session_to_order, only: :create

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, notice: t('registrations.access_denied')
  end

  def create
    return quick_authenticate_user if params[:user][:quick]

    super
  end

  def destroy
    authorize! :destroy, current_user

    super
  end

  private

  def quick_authenticate_user
    prepare_to_save
    resource.save ? sign_in_user : redirect_to(checkout_step_path, notice: t('registrations.can_not_use_account'))
  end

  def prepare_to_save
    build_resource(sign_up_params)
    resource.skip_confirmation!
  end

  def sign_in_user
    sign_in(:user, resource)
    resource.send_reset_password_instructions

    redirect_to(checkout_step_path) && return
  end

  def apply_session_to_order
    create_items if session[:guest_items]
    coupon = Coupon.find_by(id: session[:coupon], active: true, order_id: nil)
    ApplyCouponServise.new.call(coupon, current_order) if current_user && coupon
  end

  def create_items
    session[:guest_items].each do |book_id, quantity|
      CreateOrderItemService.new.call(current_order.id, book_id: book_id, quantity: quantity)
    end
  end
end
