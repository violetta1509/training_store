require 'faker'
FactoryBot.define do
  factory :book do
    association(:category)
    title { Faker::Book.title }
    price { Faker::Number.number(4).to_i / 100.00 }
    sold { Faker::Number.between(0,10) }
  end

end
