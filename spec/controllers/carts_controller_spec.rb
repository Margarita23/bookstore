require "rails_helper"

RSpec.describe CartsController, :type => :controller do
  
  describe "GET #show" do 
    let(:user) {create :user, guest: false}
    let(:cart) {create :cart, id: user.id, user_id: user.id}
      
    before do
      allow(controller).to receive(:current_user).and_return user
      allow(user).to receive(:cart).and_return cart
    end
    
    it "renders the show template" do
      get :show, id: cart.id
      expect(response).to render_template("show")
    end
  end
  
  describe "DELETE #destroy" do
    
    let(:user) {create :user, guest: false}
    let(:cart) {create :cart, id: user.id, user_id: user.id}
    let(:line_items) {create_list :line_item, 3}
    
    subject {delete :destroy, :id => cart.id}
      
    before do
      allow(controller).to receive(:current_user).and_return user
      allow_any_instance_of(User).to receive_message_chain("cart.line_items.destroy_all").and_return nil
    end
    
    it "count of line_items after destroy" do
      delete :destroy, :id => cart.id
      expect(cart.line_items.count).to eq 0 
    end
    
    it "check flash" do
      delete :destroy, :id => cart.id
      expect(flash[:notice]).to eq "Your shopping cart has been cleared"
    end
    
     it "redirect to cart_path" do
       expect(subject).to redirect_to(cart_path(cart.id))
    end
    
  end
end