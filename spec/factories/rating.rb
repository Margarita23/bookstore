FactoryGirl.define do
  factory :rating do
    headline { Faker::Lorem.sentence }
    review { Faker::Lorem.paragraph }
    grade { Faker::Number.between(0, 5) }
    book
    user
  end
end