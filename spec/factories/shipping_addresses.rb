FactoryGirl.define do
  factory :shipping_address, class: Address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    street { Faker::Address.street_name }
    city 'Winterfell'
    country 'Seven Kingdom'
    zip { Faker::Number.number(5) }
    phone { Faker::Number.number(10) }
  end
end
