FactoryGirl.define do
  factory :credit_card do
    number { Faker::Number.number(16) }
    month { Faker::Number.between(1, 12) }
    year { Faker::Number.between(2016, 2020) }
    cvv { Faker::Number.number(3) }
    user
  end
end