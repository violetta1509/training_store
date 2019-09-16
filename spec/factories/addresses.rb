FactoryBot.define do
  factory :address do
    association :addressable, factory: :user
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address.first(20) }
    city { FFaker::Address.city }
    zip { 49000 }
    country { 'UK' }
    phone { '+38002353535' }
    type { 'ShippingAddress' }
    use_billing_address { false }

    trait :user_address do
      association :addressable, factory: :user
    end

    trait :order_address do
      association :addressable, factory: :order
    end

    trait :billing_address do
      type { 'BillingAddress' }
    end

    trait :shipping_address do
      type { 'ShippingAddress' }
    end

    trait :correct_address do
      first_name { FFaker::Name.first_name }
      last_name { FFaker::Name.last_name }
      address { FFaker::Address.street_address.first(20) }
      city { FFaker::Address.city }
      zip { SecureRandom.random_number(100000) }
      country { 'UK' }
      phone { '+380999999999' }
      type { 'billing_address' }
    end

    factory :user_billing_address,  traits: %i[billing_address user_address]
    factory :user_shipping_address, traits: %i[shipping_address user_address]

    factory :order_billing_address,  traits: %i[billing_address order_address]
    factory :order_shipping_address, traits: %i[shipping_address order_address]
  end
end
