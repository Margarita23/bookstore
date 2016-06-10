require "rails_helper"

feature "Work with cart (remove, update)" do  
  
  given(:user) { create(:user) }
  given(:book_1) { create(:book) }
  given(:book_2) { create(:book) }
  
  describe "cart`s adding" do
    before(:each) do
      visit root_path
      sign_in(user)
    end
    after(:each) do
      user.destroy
    end

    scenario "remove books from cart" do
      add_book_db(book_1)
      full_cart
      visit cart_path(user.id)
      expect(page).to have_content book_1.title

      first(:link, "X").click 
      expect(page).to have_content "SUBTOTAL: $ 0"
    end

    scenario "empty cart" do
      add_book_db(book_1)
      full_cart
      visit cart_path(user.id)
      find("input[type=submit][value='EMPTY CART']").click 
      expect(page).to have_content 'Your shopping cart has been cleared'
    end
    
    scenario "chenge count of books in cart" do
      add_book_db(book_1)
      full_cart
      visit cart_path(user.id)
      expect(page.find_field("new_quantity").value).to eq "3"
      first( "input[type='number']").set("1")
      click_button'UPDATE'
      expect(page).to have_content 'Books quantity was changed'
      expect(page.find_field("new_quantity").value).to eq "1"
    end
  end


end
