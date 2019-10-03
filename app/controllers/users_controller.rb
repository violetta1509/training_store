class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @billing_address = current_user.billing_address || BillingForm.new
    @shipping_address = current_user.shipping_address || ShippingForm.new
  end

  def update
    update_billing_address if params.include?('billing_address')
    update_shipping_address if params.include?('shipping_address')
    update_email if params.include?('email_form')
    update_password if params.include?('password_form')
    update_avatar if params.include?('avatar')
  end

  private

  def update_avatar
    current_user.image = params[:avatar][:image]
    current_user.save
    redirect_to settings_path
  end

  def update_email
    assign_flash(UpdateUserService.new.call(params, current_user), I18n.t('quick_registration.autocomplete_email'))
    redirect_to settings_path
  end

  def update_password
    update_service = UpdateUserService.new.call(params, current_user)
    assign_flash(update_service, I18n.t('settings.password'))
    sign_in(:user, current_user) if update_service
    redirect_to settings_path
  end

  def update_billing_address
    @billing_address = UpdateAddressService.new.call(params, current_user)
    @shipping_address = current_user.shipping_address || ShippingForm.new
    return render :edit unless @billing_address.errors.empty?

    redirect_to settings_path
  end

  def update_shipping_address
    @shipping_address = UpdateAddressService.new.call(params, current_user)
    @billing_address = current_user.billing_address || BillingForm.new

    return render :edit unless @shipping_address.errors.empty?

    redirect_to settings_path
  end

  def assign_flash(updated, entity)
    flash[:notice] = updated ? t("settings.updated_#{entity.downcase}") : t("settings.mistake_update_#{entity.downcase}")
  end
end
