FactoryGirl.define do
  sequence :title do |n|
    "title_category_#{n}"
  end

  factory :category do
    title 
  end
end