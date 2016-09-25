require 'rails_helper'
RSpec.describe Checkout, type: :model do
  describe 'check validation' do
    before do
      allow(subject).to receive(:on_address_step).and_return(true)
      allow(subject).to receive(:on_payment_step).and_return(true)
    end
    it { should validate_presence_of(:bill_f_name).with_message(I18n.t(:'enter.billing_data.first_name')) }
    it { should validate_presence_of(:bill_l_name).with_message(I18n.t(:'enter.billing_data.last_name')) }
    it { should validate_presence_of(:bill_street).with_message(I18n.t(:'enter.billing_data.street')) }
    it { should validate_presence_of(:bill_city).with_message(I18n.t(:'enter.billing_data.city')) }
    it { should validate_presence_of(:bill_country).with_message(I18n.t(:'enter.billing_data.country')) }
    it { should validate_presence_of(:bill_zip).with_message(I18n.t(:'enter.billing_data.zip')) }
    it { should validate_presence_of(:bill_phone).with_message(I18n.t(:'enter.billing_data.phone')) }

    it { should validate_presence_of(:ship_f_name).with_message(I18n.t(:'enter.shipping_data.first_name')) }
    it { should validate_presence_of(:ship_l_name).with_message(I18n.t(:'enter.shipping_data.last_name')) }
    it { should validate_presence_of(:ship_street).with_message(I18n.t(:'enter.shipping_data.street')) }
    it { should validate_presence_of(:ship_city).with_message(I18n.t(:'enter.shipping_data.city')) }
    it { should validate_presence_of(:ship_country).with_message(I18n.t(:'enter.shipping_data.country')) }
    it { should validate_presence_of(:ship_zip).with_message(I18n.t(:'enter.shipping_data.zip')) }
    it { should validate_presence_of(:ship_phone).with_message(I18n.t(:'enter.shipping_data.phone')) }

    it { should validate_presence_of(:card_code).with_message(I18n.t(:'enter.card_code')) }
    it { should validate_numericality_of(:card_code).with_message(I18n.t(:'enter.code_numbers')) }
    it { should validate_presence_of(:card_number).with_message(I18n.t(:'enter.16_digits')) }
    it { should validate_numericality_of(:card_number).with_message(I18n.t(:'enter.card_only_num')) }
  end

  describe 'check methods' do
    let(:user) { create :user }
    let!(:cart) { create :cart, user_id: user.id }
    let!(:cart2) { create :cart }
    let(:books) { FactoryGirl.create_list :book, 2 }
    let!(:item) { create :line_item, book_id: books.last.id, cart_id: cart.id }
    let(:line_items) { create_list :line_item, 2 }
    let!(:delivery) { create :delivery }
    let!(:coupon) { create :coupon, user_id: user, cart_id: cart.id }
    let!(:credit_card) { create :credit_card, user_id: user.id }
    let(:order) { create :order }

    before do
      @checkout = Checkout.new(FactoryGirl.attributes_for(:checkout))
      allow(User).to receive(:find_by) { user }
    end

    it 'get delivery if it nil' do
      expect(@checkout.get_delivery).to eq delivery
    end

    it 'get delivery if it  not nil' do
      @checkout.delivery = delivery
      expect(@checkout.get_delivery).to eq delivery
    end

    it 'current_user' do
      expect(@checkout.current_user).to eq user
    end

    it 'order_items' do
      allow_any_instance_of(User).to receive(:cart) { cart }
      expect(@checkout.order_items).to eq [item]
    end

    it 'books_price when order_items count is 0' do
      allow_any_instance_of(User).to receive(:cart) { cart2 }
      expect(@checkout.books_price).to eq 0
    end

    it 'coupon' do
      expect(@checkout.coupon).to eq coupon
    end

    it 'coupon_discount' do
      allow(@checkout).to receive(:coupon) { nil }
      expect(@checkout.coupon_discount).to eq 0
    end

    it 'total_price' do
      total_discount = item.book.price * coupon.discount / 100
      @total_price = item.book.price - total_discount + @checkout.get_delivery.price
      allow(@checkout).to receive(:books_price) { item.book.price }
      allow(@checkout).to receive(:coupon) { coupon }
      expect(@checkout.total_price).to eq @total_price.round(2)
    end

    it 'get_coupon when coupon is nil' do
      allow(@checkout).to receive(:coupon) { nil }
      expect(@checkout.get_coupon).to eq nil
    end

    it 'get_coupon when coupon isn`t nil' do
      allow(@checkout).to receive(:coupon) { coupon }
      allow(@checkout).to receive(:order_id) { order.id }
      expect(@checkout.get_coupon).to eq true
    end

    it 'get_line_items' do
      allow(@checkout).to receive(:order_items) { [item] }
      allow(@checkout).to receive(:order_id) { order.id }
      expect(@checkout.send(:get_line_items)).to eq [item]
    end

    it 'book_bought' do
      expect(@checkout.send(:book_bought, item)).to eq true
    end

    it 'billing' do
      allow(@checkout).to receive(:order_id) { order.id }
      expect(@checkout.send(:billing)).to eq Address.last
    end

    it 'shipping is like a billing' do
      allow(@checkout).to receive(:order_id) { order.id }
      @billing = @checkout.send(:billing)
      @billing.update_attributes(order_shipping_id: order.id, order_billing_id: nil)
      allow(@checkout).to receive(:same_address) { '1' }
      expect(@checkout.send(:shipping).first_name).to eq @billing.first_name
    end

    it 'shipping is not like a billing' do
      allow(@checkout).to receive(:order_id) { order.id }
      allow(@checkout).to receive(:same_address) { '0' }
      expect(@checkout.send(:shipping)).to eq Address.last
    end

    it 'payment when credit_cart is not exist' do
      allow(@checkout).to receive(:user_id) { user.id }
      expect(@checkout.send(:payment)).to eq CreditCard.find_by(user_id: user.id)
    end

    it 'payment when credit_cart is exist' do
      allow(@checkout).to receive(:user_id) { user.id }
      allow(@checkout).to receive(:card_number) { credit_card.number }
      expect(@checkout.send(:payment)).to eq true
    end

    it 'on_address_step on address step is true' do
      allow(@checkout).to receive(:current_step) { 'address' }
      expect(@checkout.send(:on_address_step)).to eq true
    end

    it 'on_address_step on confirm step is true' do
      allow(@checkout).to receive(:current_step) { 'confirm' }
      expect(@checkout.send(:on_address_step)).to eq true
    end

    it 'on_delivery_step on delivery step is true' do
      allow(@checkout).to receive(:current_step) { 'delivery' }
      expect(@checkout.send(:on_delivery_step)).to eq true
    end

    it 'on_payment_step on delivery step is false' do
      allow(@checkout).to receive(:current_step) { 'delivery' }
      expect(@checkout.send(:on_payment_step)).to eq false
    end

    it 'on_payment_step on confirm step is true' do
      allow(@checkout).to receive(:current_step) { 'confirm' }
      expect(@checkout.send(:on_payment_step)).to eq true
    end

    it 'on_confirm_step is true' do
      allow(@checkout).to receive(:current_step) { 'confirm' }
      expect(@checkout.send(:on_confirm_step)).to eq true
    end

    it 'generate_number' do
      expect(@checkout.send(:generate_number).length).to eq 10
    end

    it 'valid_new_quantity' do
      allow_any_instance_of(User).to receive(:cart) { cart }
      expect(@checkout.valid_new_quantity).to eq [item]
    end

    it 'valid_ship_address return false' do
      allow(@checkout).to receive(:same_address) { '0' }
      expect(@checkout.valid_ship_address).to eq false
    end

    it 'valid_ship_address return true' do
      allow(@checkout).to receive(:same_address) { '1' }
      expect(@checkout.valid_ship_address).to eq true
    end

    it 'save return true' do
      allow(subject).to receive(:valid?) { true }
      allow(@checkout).to receive(:books_price) { 45 }
      expect(@checkout.save).to eq true
    end

    it 'save return false' do
      allow(subject).to receive(:valid?) { true }
      allow(@checkout).to receive(:books_price) { 0 }
      expect(@checkout.save).to eq false
    end

    describe 'valid_new_quantity' do
      let(:user_2) { create :user }
      let(:cart_2) { create :cart, user_id: user_2.id }
      let!(:some_book) { create :book, quantity: 3 }
      let!(:item_2) { create :line_item, book_id: some_book.id, cart_id: cart_2.id, quantity: 10 }
      let(:user_0) { create :user }
      let(:cart_0) { create :cart, user_id: user_0.id }
      let!(:book_0) { create :book, quantity: 0 }
      let(:item_0) { create :line_item, book_id: book_0.id, cart_id: cart_0.id, quantity: 100 }

      it 'when book_quantity more than item quantity' do
        allow_any_instance_of(User).to receive(:cart) { cart }
        expect(@checkout.valid_new_quantity).to eq [item]
      end

      it 'when book_quantity less than item quantity' do
        allow(User).to receive(:find_by) { user_2 }
        allow_any_instance_of(User).to receive(:cart) { cart_2 }
        expect(@checkout.valid_new_quantity.first.quantity).to eq some_book.quantity
      end

      it 'when book_quantity is 0' do
        allow(User).to receive(:find_by) { user_0 }
        allow_any_instance_of(User).to receive(:cart) { cart_0 }
        allow(Book).to receive(:find_by) { book_0 }
        expect(@checkout.valid_new_quantity).to eq []
      end
    end
  end
end
