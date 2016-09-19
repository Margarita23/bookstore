module FeatureHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on 'Log in'
  end
  
  def sign_up(user)
    visit "/users/sign_up"
    fill_in "user_email", :with => "www@mail.ru"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_button "Sign up"
  end
  
  def add_book_db(book)
    book.save
  end
  
   def full_cart
    visit root_path
    first( "input[type='number']").set("3")
    first(:button, "ADD TO CART").click 
  end
  
  def fill_address
    fill_in "checkout_bill_f_name", :with => "John"
    fill_in "checkout_bill_l_name", :with => "Dandy"
    fill_in "checkout_bill_street", :with => "Hanty Roude, 12"
    fill_in "checkout_bill_city", :with => "Solt Lake City"
    fill_in "checkout_bill_country", :with => "USA"
    fill_in "checkout_bill_zip", :with => "123456"
    fill_in "checkout_ship_f_name", :with => nil
    fill_in "checkout_ship_l_name", :with => nil
    fill_in "checkout_ship_street", :with => nil
    fill_in "checkout_ship_city", :with => nil
    fill_in "checkout_ship_country", :with => nil
    fill_in "checkout_ship_zip", :with => nil
    fill_in "checkout_ship_phone", :with => nil
    find(:css, "#checkbox_use_same_address").set(true)
    click_button I18n.t(:save_continue)
  end

  def fill_shipping_address
    visit "/users/sign_up"
    fill_in "user_email", :with => "www@mail.ru"
    fill_in "user_password", :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_button "Sign up"
  end
end