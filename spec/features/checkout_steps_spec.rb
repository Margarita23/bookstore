require "rails_helper"

feature "Add books to cart" do  
  
  given(:user) { create(:user, guest: false, admin: false) }
  given(:cart) { create(:cart) }
  given(:book) { create(:book) }
  given(:line_item) { create(:line_item) }
  let(:current_user) {user}
   
end