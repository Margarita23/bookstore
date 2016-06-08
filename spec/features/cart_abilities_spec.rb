require "rails_helper"

feature "Check cart`s abilities" do  
  
  given(:user) { create(:user) }
  given(:book_1) { create(:book) }
  
  describe "cart`s adding" do
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
    
    scenario "when checkout is not possible without the addition of books in cart" do
      pending
      full_cart
      visit cart_path(user.id)    
      first(:link, "X").click 
      expect(page).to have_selector ".notice", text: "Book(s) was remove from your cart"
      #expect(page).to have_content 'Book(s) was remove from your cart'
      #find("input[type=submit][value='CHECKOUT']").click
      #expect(current_path).to eq "/home/shop"
      #expect(page).to have_content 'For save order you must add books in your cart'
    end
  end
end
