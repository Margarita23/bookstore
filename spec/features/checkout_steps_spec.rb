require "rails_helper"

feature "Add books to cart", :type => :feature do  
  
  let(:cart) { create(:cart) }
  let(:book) { create(:book) }
  let(:line_item) { create(:line_item) }
  let(:user) {create :user}
  let(:deliveries) {create_list :delivery, 3}
  
  before do
    sign_up(user)
    add_book_db(book)
    full_cart
  end
  after do
    book.destroy
  end
  scenario "when user on first step :address and go on to the delivery step" do
    visit cart_path(cart.id)
    click_on(I18n.t(:checkout))
    visit checkout_path(:address)
    expect(page).to have_content("Billing address")
    fill_address
    expect(current_path).to eq ("/checkouts/delivery")
  end
  scenario "when user on first step :address" do
    visit cart_path(cart.id)
    click_on(I18n.t(:checkout))
    visit checkout_path(:address)
    expect(page).to have_content("Billing address")
  end
end