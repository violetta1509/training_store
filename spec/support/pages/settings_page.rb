class SettingsPage < BasePage

  #GENERAL
  element :settings_title, '.col-sm-4 h1.general-title-margin'
  element :avatar_title, '.col-sm-4 h3.general-subtitle'
  element :user_avatar, 'img[src="/assets/user/default-208b64f8660e86f91f38913b50493c6e3c53fc39892c54243ec829f9df60a674.png"]'
  element :address_tab, 'a[href="#address"]'
  element :privacy_tab, 'a[href="#privacy"]'
  
  #BILLING ADDRESS
  element :billing_title, '.col-md-5 h3.general-subtitle'
  element :b_first_name, '#billing_address_first_name'
  element :b_last_name, '#billing_address_last_name'
  element :b_address, '#billing_address_address'
  element :b_city, '#billing_address_city'
  element :b_zip_code, '#billing_address_zip'
  element :b_country, '#billing_address_country'
  element :b_first_country, '#billing_address_country > option:nth-child(2)'
  element :b_phone, '#billing_address_phone'
  element :b_save_button, '#new_billing_address > input.btn'

  #SHIPPING ADDRESS
  element :shipping_title, '.col-md-offset-1 h3.subtitle'
  element :sh_first_name, '#shipping_address_first_name'
  element :sh_last_name, '#shipping_address_last_name'
  element :sh_address, '#shipping_address_address'
  element :sh_city, '#shipping_address_city'
  element :sh_zip_code, '#shipping_address_zip'
  element :sh_country, '#shipping_address_country'
  element :sh_first_country, '#shipping_address_country > option:nth-child(2)'
  element :sh_phone, '#shipping_address_phone'
  element :sh_save_button, '#new_shipping_address > input.btn'
end

