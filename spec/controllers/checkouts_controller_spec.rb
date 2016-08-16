require "rails_helper"
RSpec.describe CheckoutsController, :type => :controller do
  describe "when user is a guest" do
    before do
      allow(controller).to receive(:current_user).and_return User.new
    end
    
    it{ expect(get :show, id: 'address').to redirect_to new_user_session_path }
  end
  
  describe "GET #show" do
    let(:user) {create :user} 
    let(:cart) {create :cart, user_id: user.id}
    let(:line_items) {create_list :line_item, 2}
    
    before do
      allow(controller).to receive(:current_user).and_return user
      allow(controller).to receive_message_chain('current_user.cart.line_items').and_return line_items
    end
    
    it "invalid params not go to the next step" do
      session[:last_step] = 'address'  
      get :show, id: 'address'
      expect(controller.send(:future_step?, :delivery)).to eq true
    end
    
    it "valid params on first_step" do
      session[:last_step] = 'delivery'  
      get :show, id: 'delivery'
      expect(response).to render_template "delivery"
    end
  end
   
  describe "POST #create" do 
    let (:user) {create :user}
    let(:cart) {create :cart, user_id: user.id}
    let(:line_items) {create_list :line_item, 2, cart_id: cart.id}
    subject { post :create, checkout: FactoryGirl.attributes_for(:checkout)}  
          
    it "when current_user is guest" do
      allow(controller).to receive(:current_user).and_return User.new
      expect(subject).to redirect_to new_user_session_path
    end
  end  
end