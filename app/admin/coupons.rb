ActiveAdmin.register Coupon do
  permit_params :key, :value, :order_id, :active
end
