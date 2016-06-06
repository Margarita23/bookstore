require "rails_helper"

RSpec.describe BooksController, :type => :controller do
  
  scenario "sign up user" do
    visit "/users/sign_up"

    fill_in "Email", :with => "www@mail.ru"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"

    expect(page).to have_text("Welcome! You have signed up successfully.")
  end

  
end