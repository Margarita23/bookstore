require "rails_helper"

feature "Review abilities" do  

  given(:user) { create(:user) }
    
  before(:each) do
    @category = create(:category)
    @book1 = create(:book)

    visit root_path
    sign_in(user)
    visit shopping_path
  end
  after(:each) do
    user.destroy
  end
  
  scenario "add review" do
    pending
    first(:link, "SHOP").click 
    click_on @book1.title
    click_on("Add review for this book")
    expect(page).to have_content("New Rating")
  end
  
  scenario "add review" do
    first(:link, "SHOP").click 
    click_on @book1.title
    user.destroy
    expect(current_path).to eq ("/users/sign_in")
  end
  
  
    
end
