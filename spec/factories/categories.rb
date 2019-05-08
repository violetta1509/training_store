require 'faker'
FactoryBot.define do
  factory :category do
    title { Faker::Book.title }
  end
end
