FactoryGirl.define do
  factory :checkout do 
    bill_f_name 'John'
    bill_l_name 'Dandy' 
    bill_street 'Hanty Roude, 12' 
    bill_city 'Solt Lake City'
    bill_country 'USA'
    bill_zip '123456' 
    bill_phone '1234567890' 
    ship_f_name nil
    ship_l_name nil 
    ship_street nil 
    ship_city nil
    ship_country nil 
    ship_zip nil
    ship_phone nil
    same_address '1'
    card_number '1234567890123456'
    card_code '123'
    exp_month '3'
    exp_year '2017'
  end
end