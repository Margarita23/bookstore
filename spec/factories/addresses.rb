FactoryGirl.define do
  factory :billing_address, class: Address do
    first_name "Jhon"
    last_name "Snow"
    street "Avenyu 4"
    city "Winterfell"
    country "Seven Kingdom"
    zip 48029
    phone 67490024730
    user_billing_id 
  end
end