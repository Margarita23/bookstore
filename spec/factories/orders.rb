FactoryGirl.define do
  factory :order do
    total_price 300
    number 'FG12345678'
    delivery
    user
  end
end
