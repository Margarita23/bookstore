FactoryGirl.define do
  sequence :title do |n|
    "title_#{n}"
  end
  
  factory :book do
    title
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price }
    quantity { Faker::Number.number(2) }
    bought 0
    author
    category 
  end
end
