require "rails_helper"

feature "Review abilities" do  

  given(:user) { create(:user) }
    
  before(:each) do
    @category = create(:category)
    @book1 = create(:book)
    visit root_path
    sign_in(user)
  end
  after(:each) do
    user.destroy
  end
  
  scenario "add review" do
    #visit shopping_path
    #visit book_path(@book1.id)
    #expect(page).to have_content "Add review for this book"
    #visit "/books/#{@book1.id}/ratings/new"
    #expect(page).to have_content "New Rating"
  end
  
  scenario "when guest can not add review" do
    user.destroy
    visit shopping_path
    visit book_path(@book1.id)
    expect(page).not_to have_content "Add review for this book"
  end
    
end
