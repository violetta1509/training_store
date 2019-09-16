class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(key: params[:discount][:key], active: true, order_id: nil)
    apply = ApplyCouponServise.new.call(coupon, current_order) if current_user && coupon
    session[:coupon] = coupon.id if coupon && !current_user
    setup_flash_coupon(apply, coupon)

    redirect_to cart_path
  end

  private

  def setup_flash_coupon(apply, coupon)
    apply && coupon ? flash[:notice] = t('cart.eneble_coupon') : flash[:danger] = t('cart.disabled_coupon')
  end
end
