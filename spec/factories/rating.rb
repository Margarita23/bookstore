FactoryGirl.define do
  factory :rating do
    headline { Faker::Lorem.sentence }
    review { Faker::Lorem.paragraph }
    book
    user
    grade { Faker::Number.between(0, 5) }
  end
end