FactoryBot.define do
  factory :image do
    association(:book)
    image { File.open('spec/fixtures/images/default.jpg') }
  end
end
