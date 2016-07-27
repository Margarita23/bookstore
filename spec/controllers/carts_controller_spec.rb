require "rails_helper"

RSpec.describe CartsController, :type => :controller do
  
  describe "POST #destroy" do
    let(:user) { create :user, guest: false }
    let(:user_2) { create :user, guest: false }
    let(:cart) { FactoryGirl.create :cart, user_id: user.id }
    let(:cart_some) { FactoryGirl.create :cart }
    let(:line_item) { FactoryGirl.create :line_item, cart_id: cart.id }
    it "delete all items" do
      allow(controller).to receive(:current_user).and_return user
      allow(controller).to receive(:carts_items).and_return [line_item]
      expect { cart.destroy }.to change {LineItem.count}.by(-1)
    end
    
    it "path after delete" do
      allow(controller).to receive(:current_user).and_return user_2
      allow(controller).to receive(:carts_items).and_return []
      delete :destroy, id: cart_some.id
      assert_redirected_to cart_url(cart_some.id)
    end
    it "already empty cart" do
      allow(controller).to receive(:current_user).and_return user_2
      allow(controller).to receive(:carts_items).and_return []
      delete :destroy, id: cart_some.id
      expect(flash[:alert]).to eq "Cart is already empty"
    end  
  end
end