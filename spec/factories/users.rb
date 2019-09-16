FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'Faker121word' }
    after(:create, &:confirm)

    trait :with_order do
      after(:create) do |user|
        user.orders << create(:order, :with_order_items, user: user)
      end
    end

    trait :with_order_coupon do
      after(:create) do |user|
        user.orders << create(:order, :with_coupon, user: user)
      end
    end
  end
end
