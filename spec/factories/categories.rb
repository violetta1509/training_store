FactoryBot.define do
  factory :category do
    title { FFaker::Book.title }
  end
end
