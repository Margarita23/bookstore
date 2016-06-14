require "rails_helper"

feature "Add books to cart" do  
  
  given(:user) { create(:user, guest: false) }
  given(:cart) { create(:cart) }
  given(:book) { create(:book) }
  given(:line_item) { create(:line_item) }
  
 
  describe "checkout moving step by step" do
    
    scenario "when user on first step" do
      visit new_checkout_path
      expect(page).to have_content("BILLING ADDRESS")
    end
  
  end
end