FactoryBot.define do
  factory :book do
    association :category
    title { FFaker::Book.title }
    price { FFaker::PhoneNumber.area_code / 100.00 }
    sold { FFaker::PhoneNumber.area_code }
    description { FFaker::Lorem.paragraph }

    after(:create) do |book|
      book.images << create(:image, book: book)
    end
  end

  trait :with_author do
    after(:create) do |book|
      book.authors << create(:author)
    end
  end
end
