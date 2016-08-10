require "rails_helper"

feature "Review abilities" do  

  let!(:user) { create(:user, admin: false) }
  let!(:category) { create :category }
  let!(:book1) { create :book }

  scenario "add review" do
    sign_up(user)
    visit book_path(book1.id)
    expect(page).to have_content "Add review for this book"
    user.destroy
  end
  
  scenario "add review" do
    sign_up(user)
    visit book_path(book1.id)
    click_on "Add review for this book"
    expect(page).to have_content "New Rating"
    user.destroy
  end
  
  scenario "when guest can not add review" do
    visit book_path(book1.id)
    click_on "Add review for this book"
    expect(page).to have_content "You are not authorized to access this page."
  end
    
end