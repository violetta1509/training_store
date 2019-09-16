FactoryBot.define do
  factory :review do
    association :book
    association :user
    title { FFaker::Book.title }
    body { FFaker::Lorem.paragraph }
    score { rand(1..5) }
  end
end
