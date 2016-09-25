FactoryGirl.define do
  factory :billing_address, class: Address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    street { Faker::Address.street_name }
    city 'Winterfell'
    country 'Seven Kingdom'
    zip { Faker::Number.number(5) }
    phone '123456789'
  end
end
