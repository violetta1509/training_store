ActiveAdmin.register Order do
  permit_params :status, :discount

  index do
    id_column
    column :created_at
    column :status
    actions defaults: false do |order|
      item I18n.t('active_admin.view'), admin_order_path(order)
    end
  end

  show do
    columns do
      column do
        attributes_table do
          row :status
          row :user_id
          row :created_at
          row :discount
        end
      end

      column do
        panel I18n.t('active_admin.order_items') do
          order.order_items.each do |item|
            li link_to(I18n.t('active_admin.order_item'), admin_order_item_path(item))
          end
        end
      end
    end
  end
end
