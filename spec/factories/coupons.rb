FactoryGirl.define do
  factory :coupon do
    code "MyString"
    discount "9.99"
    order nil
    user nil
    cart nil
  end
end
