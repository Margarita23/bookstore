FactoryGirl.define do 
  factory :book do
    title
    description "cool description"
    price 15.2
    quantity 55
    bought 0
    author
    category 
  end
end
