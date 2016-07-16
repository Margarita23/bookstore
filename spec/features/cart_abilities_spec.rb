require "rails_helper"

feature "Check cart`s abilities" do  
    
  let(:user) { create(:user, guest: false, admin: false) }
  let(:book_1) { create(:book) }
  before(:each) do
    visit root_path
    sign_in(user)
    add_book_db(book_1)
    full_cart
  end
  after(:each) do
    book_1.destroy
    user.destroy
  end

  scenario "when checkout is not possible after empty cart button click" do 
    visit cart_path(user.id)
    find("input[type=submit][value='EMPTY CART']").click
    
    expect(page).to have_content 'Your shopping cart has been cleared'
end

  scenario "continue shopping button" do
    visit cart_path(user.id)
    find("input[type=submit][value='CONTINUE SHOPPING']").click 
    expect(current_path).to eq "/home/shop"
  end
    
end



