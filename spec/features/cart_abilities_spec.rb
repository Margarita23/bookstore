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

    scenario "when checkout is not possible without the addition of books in cart" do
      visit cart_path(user.id)    
      find("input[type=submit][value='CHECKOUT']").click
      expect(page).to have_content 'CHECKOUT'
      #expect(page).to have_content 'Ordering should be at least one book'
    end

    scenario "continue shopping button" do
      full_cart
      visit cart_path(user.id)
      find("input[type=submit][value='CONTINUE SHOPPING']").click 
      expect(current_path).to eq "/home/shop"
    end
  end
end
