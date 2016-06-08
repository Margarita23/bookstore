require "rails_helper"

feature "Add books to cart" do  

  given(:user) { create(:user) }
    
  scenario "when go to shop even current user is guest" do
    visit root_path
    first(:link, "SHOP").click 
    expect(current_path).to eq ("/home/shop")
  end
    
  scenario "when choose category" do 
    category = create(:category)
    book1 = create(:book)
    book2 = create(:book)
    book3 = create(:book, category: category)
    book4 = create(:book, category: category)

    visit root_path
    sign_in(user)
    visit shopping_path
    
    visit category_path(category)

    expect(page).to have_content book3.title
    expect(page).to have_content book4.title
    
    user.destroy
  end
  
  scenario "when add book in cart from shop" do
    visit root_path
    sign_in(user)
    visit shopping_path
  end
end
