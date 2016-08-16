FactoryGirl.define do
  factory :line_item do
    quantity 2
    book
    cart
  end

end