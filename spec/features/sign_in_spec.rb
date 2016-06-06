require "rails_helper"

RSpec.describe BooksController, :type => :controller do
  
  scenario "sign in user" do
    visit "/users/sign_in"

    fill_in "Email", :with => "qqq@mail.ru"
    fill_in "Password", :with => "][';/./.]"
    click_button "Log in"

    expect(page).to have_content 'Invalid email or password'
  end

  
end