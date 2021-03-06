require 'rails_helper'
RSpec.describe CheckoutsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create :user }
    let(:cart) { create :cart, user_id: user.id }
    let(:line_items) { create_list :line_item, 2 }

    before do
      allow(controller).to receive(:current_user).and_return user
      allow(controller).to receive_message_chain('current_user.cart.line_items').and_return line_items
    end

    it 'can move on previous step' do
      session[:last_step] = 'delivery'
      get :show, id: 'address'
      expect(session[:last_step]).to eq :address
    end

    it 'valid params on first_step' do
      allow(controller).to receive(:future_step?) { true }
      session[:last_step] = 'address'
      get :show, id: 'delivery'
      expect(session[:last_step]).to eq :delivery
    end

    it 'future_step? is false' do
      session[:last_step] = 'address'
      get :show, id: 'payment'
      expect(session[:last_step]).to eq 'address'
    end
  end

  describe 'POST #create' do
    let!(:user) { create :user }
    let!(:cart) { create :cart, user_id: user.id }
    let!(:items) { create_list :line_item, 2, cart_id: cart.id }
    let(:order) { create :order }
    subject { post :create, checkout: FactoryGirl.attributes_for(:checkout) }

    it 'when line_item`s count is not 0 but @checkout is not save' do
      allow(controller).to receive(:current_user) { user }
      allow(assigns(:checkout)).to receive(:order_items) { items }
      allow_any_instance_of(Checkout).to receive(:current_user) { user }
      @checkout = Checkout.new
      expect(post :create, checkout: @checkout).to redirect_to checkout_path(:confirm)
    end

    it '@checkout save return true' do
      allow(controller).to receive(:current_user) { user }
      allow(assigns(:checkout)).to receive(:order_items) { items }
      allow_any_instance_of(Checkout).to receive(:order_id) { order.id }
      allow_any_instance_of(Checkout).to receive(:save) { true }
      allow_any_instance_of(Checkout).to receive(:current_user) { user }
      @checkout = Checkout.new(FactoryGirl.attributes_for(:checkout))
      expect(post :create, checkout: @checkout).to redirect_to new_order_show_path(order.id)
    end
  end
end
