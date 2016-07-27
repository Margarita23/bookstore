require "rails_helper"

feature "Add books to cart" do  
  
  given(:user) { create :user }
  given(:book_1) { create(:book) }

  describe "cart`s adding" do
    
    before do
      visit root_path
      add_book_db(book_1)
      sign_up(user)
    end
    after do
      user.destroy
    end
  
    scenario "Add book to cart" do
      first(:button, "ADD TO CART").click 
      expect(page).to have_content 'Book(s) was(were) added in your cart'
      expect(current_path).to eq ("/")
    end

    scenario "Default value" do  
     expect(first("input[type='number']").value).to eq("1")
    end

    scenario "add -1 book" do
      first( "input[type='number']").set("-1")
      first(:button, "ADD TO CART").click 
      expect(page).to have_content 'Book can not be add to your cart, please enter information.'
    end

    scenario "add 0 book" do
      first( "input[type='number']").set("0")
      first(:button, "ADD TO CART").click 
      expect(page).to have_content 'Book can not be add to your cart, please enter information.'
    end

    scenario "add book`s count more than count in store " do
      first( "input[type='number']").set("10000")
      first(:button, "ADD TO CART").click 
      expect(page).to have_content 'In your basket was(were) added all this book(s)'
    end
  end
  
   before do
      visit root_path
      add_book_db(book_1)
    end
  
    scenario "when guest add books" do
      visit root_path
      first(:button, "ADD TO CART").click 
      expect(page).to have_content 'You are not authorized to access this page. '
      expect(current_path).to eq ("/")
    end

end