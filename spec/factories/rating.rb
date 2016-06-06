FactoryGirl.define do
  factory :rating do
    headline "Best book all over the world"
    review "Some awesome review"
    book
    user
    grade 3
  end
end