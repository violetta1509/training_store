FactoryBot.define do
  factory :delivery_service do
    from_days { rand(1..5) }
    to_days { rand(5..10) }
    name { FFaker::Name.first_name }
    price { rand(10..30) }
  end
end
