require "rails_helper"
feature "Signing in" do
  
  background do
    User.create(:email => 'user@example.com', :password => 'secret_pass')
  end

  scenario "sign in user" do
    visit "/users/sign_in"
    fill_in "Email", :with => "qqq@mail.ru"
    fill_in "Password", :with => "][';/./.]"
    click_button "Log in"
    expect(page).to have_content "Invalid Email or password."
    expect(current_path).to eq ("/users/sign_in")
  end

  scenario "Signing in with correct credentials" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'user@example.com'
    fill_in 'Password', :with => 'secret_pass'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end