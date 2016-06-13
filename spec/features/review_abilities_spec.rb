require "rails_helper"

feature "Review abilities" do  

  given(:user) { create(:user, guest: false) }
  given(:book1) { create(:book) }
    
  before(:each) do
    @category = create(:category)
    visit root_path
    sign_in(user)
  end
  after(:each) do
    user.destroy
  end
  
  scenario "add review" do
    visit book_path(book1.id)
    expect(page).to have_content "Add review for this book"
    click_on "Add review for this book"
    expect(page).to have_content "New Rating"
  end
  
  scenario "when guest can not add review" do
    user.destroy
    visit book_path(book1.id)
    click_on "Add review for this book"
    expect(page).to have_content "You are not authorized to access this page."
  end
    
end
