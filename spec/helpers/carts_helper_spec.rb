require 'rails_helper'

describe CartsHelper do
  let(:user) { create :user }
  let(:cart) { create :cart, user_id: user.id }
  let!(:book_1) { create :book }
  let!(:book_2) { create :book }
  let!(:item_1) { create :line_item, cart_id: cart.id, book_id: book_1.id }
  let!(:item_2) { create :line_item, cart_id: cart.id, book_id: book_2.id }
  let(:coupon) { create :coupon }

  before do
    allow(helper).to receive(:current_user) { user }
    allow_any_instance_of(User).to receive('cart') { cart }
  end

  it '@sub_total is 0' do
    allow_any_instance_of(User).to receive_message_chain('cart.line_items') { [] }
    expect(helper.sub_total).to eq(0)
  end

  it '#quantity_incart' do
    allow_any_instance_of(User).to receive_message_chain('cart.line_items') { [item_1.quantity, item_2.quantity] }
    @quantity = item_1.quantity + item_2.quantity
    expect(helper.quantity_incart).to eq @quantity
  end

  it '#cart_fully return quantity items in cart adn total price' do
    allow_any_instance_of(User).to receive_message_chain('cart.line_items') { [item_1] }
    @quantity = item_1.quantity
    @sub_total = book_1.price * book_1.quantity
    allow(helper).to receive(:quantity_incart) { @quantity }
    allow(helper).to receive(:sub_total) { @sub_total }
    expect(helper.cart_fully).to eq '('+ @quantity.to_s + ')$' + @sub_total.to_s
  end

  it '#cart_fully return empty' do
    allow_any_instance_of(User).to receive_message_chain('cart.line_items') { [] }
    expect(helper.cart_fully).to eq I18n.t(:empty)
  end

  it '#current_cart' do
    expect(helper.current_cart).to eq cart
  end

  it '#coupon_code_value return nil' do
    expect(helper.coupon_code_value).to eq nil
  end

  it '#coupon_code_value return coupon code' do
    allow_any_instance_of(Cart).to receive('coupon') { coupon }
    expect(helper.coupon_code_value).to eq coupon.code
  end

  it '#discount return 0' do
    expect(helper.discount).to eq 0
  end

  it '#discount return coupon discount' do
    allow_any_instance_of(Cart).to receive('coupon') { coupon }
    expect(helper.discount).to eq coupon.discount
  end

  it 'sub_total_with_discount when discount is 0 %' do
    allow_any_instance_of(User).to receive_message_chain('cart.line_items') { [item_1] }
    @sub_total = book_1.price * book_1.quantity
    allow(helper).to receive(:sub_total) { @sub_total }
    expect(helper.sub_total_with_discount).to eq @sub_total.round(2)
  end

  it 'sub_total_with_discount with discount' do
    allow_any_instance_of(User).to receive_message_chain('cart.line_items') { [item_1] }
    allow_any_instance_of(Cart).to receive('coupon') { coupon }
    @sub_total = book_1.price * book_1.quantity
    allow(helper).to receive(:sub_total) { @sub_total }
    discount = (helper.sub_total * helper.discount) / 100
    total = helper.sub_total - discount
    expect(helper.sub_total_with_discount).to eq total.round(2)
  end
end
