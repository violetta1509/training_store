FactoryBot.define do
  factory :order_item do
    association :order
    association :book
    quantity { rand(1..10) }
  end
end
