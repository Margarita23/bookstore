FactoryGirl.define do
  factory :billing_address, class: Address do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    street { Faker::Address.street_name }
    city "Winterfell"
    country "Seven Kingdom"
    zip 48029
    phone 67490024730
  end
end