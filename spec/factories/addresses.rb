FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    zip{ FFaker::AddressUS.postcode }
    phone { FFaker::PhoneNumber.phone_number }
  end
end
