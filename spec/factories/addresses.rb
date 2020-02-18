FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressAU.postcode }
    country { ['Ukraine', 'Germane', 'USA', 'UK'].sample }
    phone { FFaker::PhoneNumber.phone_number }
  end
end
