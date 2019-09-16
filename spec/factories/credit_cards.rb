FactoryBot.define do
  factory :credit_card do
    association :order
    number { 16.times.map{rand(10)}.join }
    cvv { FFaker::PhoneNumber.area_code }
    name { FFaker::Name.first_name }
    expiry_date { (sprintf '%02d', Time.now.strftime('%m').to_i + 1) + '/'+ Time.now.strftime('%Y').last(2) }
  end
end
