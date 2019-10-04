FactoryBot.define do
  factory :order do
    association :user
    total { 10 }
    status { Order.aasm(:status).states.first.name }
    checkout { Order.aasm(:checkout).states.first.name }

    trait :with_order_items do
      after(:create) do |order|
        order.order_items << create(:order_item)
      end
    end

    trait :with_coupon do
      after(:create) do |order|
        order.coupon = create(:coupon, :disabled_coupon, order: order)
      end
    end
  end
end
