FactoryGirl.define do
  factory :address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    country { Faker::Address.country }
    zip { Faker::Address.zip }
    phone '0987654321'
  end
end
