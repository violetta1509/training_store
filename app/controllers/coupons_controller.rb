class CouponsController < ApplicationController
  def update
    coupon = Coupon.find_by(key: params[:discount][:key], active: true, order_id: nil)
    coupon ? apply_coupon(coupon) : flash[:danger] = t('cart.disabled_coupon')

    redirect_to cart_path
  end

  private

  def apply_coupon(coupon)
    coupon_for_guest(coupon) unless current_user
    coupon_for_user_order(coupon) if current_user
  end

  def coupon_for_user_order(coupon)
    apply = ApplyCouponServise.new.call(coupon, current_order)
    apply ? flash[:notice] = t('cart.eneble_coupon') : flash[:danger] = t('cart.disabled_coupon')
  end

  def coupon_for_guest(coupon)
    session[:coupon] = coupon.id
    flash[:notice] = t('cart.eneble_coupon')
  end
end
