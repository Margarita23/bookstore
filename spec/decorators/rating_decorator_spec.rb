require 'rails_helper'
describe RatingDecorator do
  let!(:rating) { FactoryGirl.create(:rating).decorate }
  it '#email return user`s email' do
    expect(rating.email).to eq rating.user.email
  end

  it '#first_name return user`s first_name' do
    expect(rating.first_name).to eq rating.user.billing_address.first_name
  end

  it '#last_name return user`s last_name' do
    expect(rating.last_name).to eq rating.user.billing_address.last_name
  end

  it '#author_name return first and last name' do
    expect(rating.author_name).to eq rating.user.billing_address.first_name.to_s + ' ' + rating.user.billing_address.last_name.to_s
  end

  it '#author_name return email' do
    allow(rating).to receive_message_chain('first_name.blank?') { true }
    expect(rating.author_name).to eq rating.user.email
  end
end
