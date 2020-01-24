FactoryBot.define do
  factory :category do
    title { 'WEB' }
    slug { FFaker::Internet.slug }
  end
end
