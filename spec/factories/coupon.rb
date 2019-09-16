FactoryBot.define do
  factory :coupon do
    association :order
    key { FFaker::BaconIpsum.word }
    value { FFaker::Random.rand(10..15) }
    active { true }
  end

  trait :value_less_order do
    value { FFaker::Random.rand(0..9) }
  end

  trait :disabled_coupon do
    active { false }
  end

  trait :enabled_coupon do
    active { true }
  end
end
