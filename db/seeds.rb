require 'faker'
BOOK_IMGS = [
  'https://gdurl.com/gphg',
  'https://gdurl.com/CZcD',
  'https://gdurl.com/0BSY',
  'https://gdurl.com/525U',
  'https://gdurl.com/hUyY',
  'https://gdurl.com/ucaQ',
  'https://gdurl.com/tiFk',
  'https://gdurl.com/s4xX',
  'https://gdurl.com/I1Jz',
  'https://gdurl.com/XoSU',
  'https://gdurl.com/pAD8',
  'https://gdurl.com/N4gb',
  'https://gdurl.com/p15l',
  'https://gdurl.com/PYWT',
  'https://gdurl.com/hf_k',
  'https://gdurl.com/mscc'
  ]
def random_image
  BOOK_IMGS[rand(1..16)]
end

30.times { Author.create!(name: Faker::Name.name) }

['Mobile development',
  'Photo',
  'Web development',
  'Web design'].each { |category| Category.create!(title: category) }
categories = Category.all

30.times do |i|
  book = Book.create!(title: Faker::Book.title,
                    price: Faker::Number.number(4).to_i / 100.00,
                    description: Faker::Lorem.paragraph(10),
                    quantity: Faker::Number.between(0,10),
                    category_id: categories.sample.id,
                    sold: Faker::Number.between(0,10),
                    publication_year: Faker::Number.between(1992, Time.now.year),
                    material: Faker::Science.element,
                    depth: Faker::Number.decimal(2),
                    width: Faker::Number.decimal(2),
                    height: Faker::Number.decimal(2),
                    image_name: random_image)
  book.authors << Author.all.sample(rand(1..2))
end
