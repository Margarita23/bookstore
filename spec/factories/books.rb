FactoryGirl.define do

  factory :book do
    title { Faker::Name.title }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price }
    quantity { Faker::Number.number(2) }
    bought 0
    author
    category 
  end
end
