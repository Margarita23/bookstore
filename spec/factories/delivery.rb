FactoryGirl.define do
  factory :delivery do
    add_attribute(:method) { Faker::Lorem.word }
    price 15
  end
end
