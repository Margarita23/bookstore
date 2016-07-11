require "rails_helper"

feature "Add books to cart" do  

  given(:user) { create(:user, guest: false) }
    
  before(:each) do
    @category = create(:category)
    @book1 = create(:book)
    @book2 = create(:book)
    @book3 = create(:book, category: @category)
    @book4 = create(:book, category: @category)

    visit root_path
    sign_in(user)
    visit shopping_path
  end
  after(:each) do
    user.destroy
  end
  
  scenario "when go to shop even current user is guest" do
    user.destroy
    visit root_path
    first(:link, "SHOP").click 
    expect(current_path).to eq ("/home/shop")
  end
    
  scenario "when choose category" do 
    visit category_path(@category)
    expect(page).not_to have_content @book1.title
    expect(page).not_to have_content @book2.title
    expect(page).to have_content @book3.title
    expect(page).to have_content @book4.title
  end
  
  scenario "when add book in cart from shop" do
    click_on @book1.title
    click_on("ADD TO CART")
    expect(page).to have_content "Book(s) was(were) added in your cart"
  end
end