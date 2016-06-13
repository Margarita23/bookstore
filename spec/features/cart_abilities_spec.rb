require "rails_helper"

feature "Check cart`s abilities" do  
    
  given(:user) { create(:user, guest: false) }
  given(:book_1) { create(:book) }
  before(:each) do
    visit root_path
    sign_in(user)
    add_book_db(book_1)
  end
  after(:each) do
    book_1.destroy
    user.destroy
  end

  scenario "when checkout is not possible after empty cart button click" do
    full_cart
    visit cart_path(user.id)    
    find("input[type=submit][value='EMPTY CART']").click
    expect(page).to have_content 'Your shopping cart has been cleared'
    find("input[type=submit][value='CHECKOUT']").click
    expect(current_path).to eq "/home/shop"
    expect(page).to have_content 'For save order you must add books in your cart'
  end

  scenario "continue shopping button" do
    full_cart
    visit cart_path(user.id)
    find("input[type=submit][value='CONTINUE SHOPPING']").click 
    expect(current_path).to eq "/home/shop"
  end
    
end



