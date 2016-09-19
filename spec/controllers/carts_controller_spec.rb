require "rails_helper"
RSpec.describe CartsController, :type => :controller do
  
  describe "GET #show" do
    let(:user) { create :user }
    let(:cart) { FactoryGirl.create :cart, user_id: user.id }
    it "session[:last_step] is delivery" do
      allow(controller).to receive(:current_user).and_return user
      session[:last_step] = 'delivery'
      get :show, id: cart.id
      expect(session[:last_step]).to eq 'delivery'
    end
  end
  
  describe "POST#destroy" do
    let(:user) { create :user }
    let(:user_2) { create :user }
    let!(:cart) { FactoryGirl.create :cart, user_id: user.id }
    let!(:cart_some) { FactoryGirl.create :cart, user_id: user_2.id}
    let!(:items) { FactoryGirl.create_list :line_item, 2, cart_id: cart.id }
    
    before do
      allow(controller).to receive(:current_user).and_return user
    end
    
    it "delete all items" do
      allow(controller).to receive(:carts_items).and_return cart.line_items
      expect{delete :destroy, id: cart_some.id}.to change {LineItem.count}.by(-items.count)
    end
    
    it "path after delete" do
      allow(controller).to receive(:carts_items).and_return cart_some.line_items
      delete :destroy, id: cart_some.id
      assert_redirected_to cart_url(cart_some.id)
    end
    it "already empty cart" do
      allow(controller).to receive(:carts_items).and_return cart_some.line_items
      delete :destroy, id: cart_some.id
      expect(flash[:alert]).to eq "Cart is already empty"
    end  
  end 
  
  describe "PUT#update_items" do
    let(:user) { create :user }
    let!(:cart) { FactoryGirl.create :cart, user_id: user.id }
    let!(:items) { FactoryGirl.create_list :line_item, 2, cart_id: cart.id }
    let(:coupon) {create :coupon}
    before do
      request.env["HTTP_REFERER"] = "back"
      allow(controller).to receive(:current_user) {user}
    end
    it "redirect to root path cause ids is nil" do
      put :update_items, id: cart.id
      expect(response).to redirect_to root_path
    end
    
    it "responce return back path" do
      @ids = {"#{items.first.id}" => "3", "#{items.last.id}" => "3"}
      put :update_items, id: cart.id, ids: @ids, coupon: {}
      expect(response).to redirect_to "back"
    end
    
    it "check flash notice" do
      @ids = {"#{items.first.id}" => "3", "#{items.last.id}" => "3"}
      put :update_items, id: cart.id, ids: @ids, coupon: {}
      expect(flash[:notice]).to eq I18n.t(:quantity_changed)
    end
    
    it "check flash alert return nil" do
      @ids = {"#{items.first.id}" => "3", "#{items.last.id}" => "3"}
      put :update_items, id: cart.id, ids: @ids, coupon: {}
      expect(flash[:alert]).to eq nil
    end
    
    it "check flash notice" do
      @ids = {"#{items.first.id}" => "3", "#{items.last.id}" => "3"}
      put :update_items, id: cart.id, ids: @ids, coupon: {code: "123456789"}
      expect(flash[:alert]).to eq I18n.t(:coupon_code_is_not_right)
    end
  end
end