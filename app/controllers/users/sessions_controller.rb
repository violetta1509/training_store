class Users::SessionsController < Devise::SessionsController
  after_action :apply_session_to_user, only: :create

  def create
    super
  end

  def apply_session_to_user
    coupon = Coupon.find_by(id: session[:coupon], active: true, order_id: nil)
    ApplyCouponServise.new.call(coupon, current_order) if current_user && coupon
  end

  def after_sign_in_path_for(_resource)
    current_user.admin ? admin_root_path : root_path
  end
end
