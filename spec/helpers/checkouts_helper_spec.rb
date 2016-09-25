require 'rails_helper'
describe CheckoutsHelper do
  let(:user) { create :user }
  let(:address) { create :address, user_billing_id: user.id }
  let!(:address_ship) { create :address, user_shipping_id: user.id }

  before do
    session[:checkout] = {}
    allow(helper).to receive(:current_user) { user }
  end

  it 'bill_first_name_value return 0' do
    address_1 = Address.create
    allow_any_instance_of(User).to receive('billing_address') { address_1 }
    expect(helper.bill_first_name_value).to eq nil
  end

  it 'bill_first_name_value return session data' do
    session[:checkout]['bill_f_name'] = 'John'
    address_1 = Address.create
    allow_any_instance_of(User).to receive('billing_address') { address_1 }
    expect(helper.bill_first_name_value).to eq 'John'
  end

  it 'bill_first_name_value return first name' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.bill_first_name_value).to eq address.first_name
  end

  it 'bill_last_name_value return last name' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.bill_last_name_value).to eq address.last_name
  end

  it 'bill_street_value return street' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.bill_street_value).to eq address.street
  end

  it 'bill_city_value return city' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.bill_city_value).to eq address.city
  end

  it 'bill_country_value return country' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.bill_country_value).to eq address.country
  end

  it 'bill_zip_value return zip' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.bill_zip_value).to eq address.zip
  end

  it 'bill_phone_value return phone' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.bill_phone_value).to eq address.phone
  end

  it 'ship_first_name_value return first_name' do
    allow_any_instance_of(User).to receive('billing_address') { address }
    expect(helper.ship_first_name_value).to eq address_ship.first_name
  end

  it 'ship_first_name_value return first_name' do
    allow_any_instance_of(User).to receive('shipping_address') { address_ship }
    expect(helper.ship_first_name_value).to eq address_ship.first_name
  end

  it 'ship_last_name_value return last_name' do
    allow_any_instance_of(User).to receive('shipping_address') { address_ship }
    expect(helper.ship_last_name_value).to eq address_ship.last_name
  end

  it 'ship_street_value return street' do
    allow_any_instance_of(User).to receive('shipping_address') { address_ship }
    expect(helper.ship_street_value).to eq address_ship.street
  end

  it 'ship_city_value return city' do
    allow_any_instance_of(User).to receive('shipping_address') { address_ship }
    expect(helper.ship_city_value).to eq address_ship.city
  end

  it 'ship_country_value return country' do
    allow_any_instance_of(User).to receive('shipping_address') { address_ship }
    expect(helper.ship_country_value).to eq address_ship.country
  end

  it 'ship_zip_value return zip' do
    allow_any_instance_of(User).to receive('shipping_address') { address_ship }
    expect(helper.ship_zip_value).to eq address_ship.zip
  end

  it 'ship_phone_value return phone' do
    allow_any_instance_of(User).to receive('shipping_address') { address_ship }
    expect(helper.ship_phone_value).to eq address_ship.phone
  end

  it 'hidden_card_number return anything' do
    assign(:checkout, Checkout.new)
    expect(helper.hidden_card_number).to eq ''
  end

  it 'hidden_card_number return hidden card_number' do
    assign(:checkout, Checkout.new(card_number: '1234567890123456'))
    expect(helper.hidden_card_number).to eq '**** **** **** 3456'
  end

  it 'checkout_errors_message return anything' do
    @checkout = Checkout.new
    assign(:checkout, @checkout)
    expect(helper.checkout_errors_message(@checkout)).to eq ''
  end
end
