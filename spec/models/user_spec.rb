require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:orders) }
  it { should have_many(:ratings) }
  it { should have_one(:cart) }
  it { should have_one(:billing_address) }
  it { should have_one(:shipping_address) }

  before do
    @auth = OmniAuth::AuthHash.new({
                  provider: 'facebook',
                  uid: '123545', 
                  info: {email: "test@test.ru"}
                  })
  end
  it "#from_omniauth" do
    expect(User.from_omniauth(@auth)).to eq User.first 
  end
end