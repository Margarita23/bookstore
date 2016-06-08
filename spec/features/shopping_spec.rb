require "rails_helper"

feature "Add books to cart" do  
  
  given(:user) { create(:user) }
  given(:book_1) { create(:book) }
  given(:category_1) { create(:category) }
 
  describe "cart`s adding" do
    before(:each) do
      visit root_path
      add_book_db(book_1)
      sign_in(user)
    end
    after(:each) do
      user.destroy
    end
    
    scenario "when go to shop" do
      first(:link, "SHOP").click 
      expect(current_path).to eq ("/home/shop")
    end
    
    scenario "when choose category" do
      visit shopping_path
      first(:link, category.title).click 
      expect(current_path).to eq ("/home/shop")
    end

  end

end
