require 'rails_helper'
feature 'Signing up' do
  scenario 'sign up user' do
    visit '/users/sign_up'
    fill_in 'user_email', with: 'www@mail.ru'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')
    expect(current_path).to eq root_path
  end
end
