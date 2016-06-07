module FeatureHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_on 'Log in'
  end
  
  def add_book_db(book)
    book.save
  end
  
   def full_cart
    visit root_path
    first( "input[type='number']").set("3")
    first(:button, "ADD TO CART").click 
  end
end