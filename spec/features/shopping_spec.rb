require "rails_helper"

feature "Add books to cart" do  

  let!(:user) { create(:user) }
  let!(:category) { create :category  }
  let!(:category2) { create :category  }
  let!(:book1) { create :book, category_id: category2.id }
  let!(:book2) { create :book, category_id: category2.id }
  let!(:book3) { create :book, category_id: category.id }
  let!(:book4) { create :book, category_id: category.id }
  
  scenario "book in shop" do
    visit shopping_path
    first(:link, "SHOP").click 
    expect(page).to have_content book1.title
    expect(page).to have_content book2.title
    expect(page).to have_content book3.title
    expect(page).to have_content book4.title
  end
  
  scenario "when go to shop even current user is guest" do
    visit root_path
    first(:link, "SHOP").click 
    expect(current_path).to eq ("/home/shop")
  end
    
  scenario "when choose category" do 
    visit category_path(category.id)
    expect(page).not_to have_content book1.title
  end
  
  scenario "when user guest" do
    user.destroy
    visit shopping_path
    click_on(book3.title)
    click_on("ADD TO CART")
    expect(page).to have_content "You are not authorized to access this page. "
  end
  
end