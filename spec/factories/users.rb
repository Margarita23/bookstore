FactoryGirl.define do
  
  sequence :email do |n|
    "email_example#{n}@mail.ru"
  end
  
  factory :user do
    email
    password "poilkj,mn"
  end
end