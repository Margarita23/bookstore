require "rails_helper"

feature "Review abilities" do  

  given(:user) { create(:user) }
  
   before(:each) do
    @category = create(:category)
    @book1 = create(:book)
    visit root_path
    sign_in(user)
    user.role = "member"
  end
  after(:each) do
    user.destroy
  end
  
  scenario "first_step" do
    #visit cart_path(user.id)
    visit checkout_path
    #click_link "CHECKOUT"
    #expect(current_path).to eq "/checkout/new"
    #expect(page).to have_content "BILLING ADDRESS"
  end
  
end