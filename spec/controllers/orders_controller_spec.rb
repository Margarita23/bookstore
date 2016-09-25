require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    let(:user) { create :user }
    let!(:orders) { create_list :order, 3 }

    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'assigns @orders' do
      allow_any_instance_of(User).to receive(:orders).and_return(orders)
      get :index
      expect(assigns(:orders)).to eq orders
    end
    it 'assigns @order when view is true' do
      get :index, id: orders.first.id, view: true
      expect(assigns(:order)).to eq orders.first
    end

    it 'assigns @order is nil when view is false or nil' do
      get :index, id: orders.last.id
      expect(assigns(:order)).to eq nil
    end
  end
end
