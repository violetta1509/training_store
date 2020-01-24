FactoryBot.define do
  factory :book do
    slug { FFaker::Internet.slug }
    publication_year { 1998 }
    material { 'cotton' }
    width { 10.2 }
    height { 3 }
    depth { 15 }
    sold { 0 }
    quantity { 20 }
    description { 'New Book' }
    price { 20.99 }
    title { 'Book_name' }
    association(:category)
    end
end