require "rails_helper"
RSpec.describe CheckoutsController, :type => :controller do
  describe "GET #show" do
    let(:user) {create :user} 
    
    it "guard clause" do
      allow(controller).to receive(:current_user).and_return nil
      expect(get :show, id: 'address').to redirect_to new_user_session_path
    end
    
    it "invalid params not go to the next step" do
      allow(controller).to receive(:current_user).and_return user
      session[:last_step] = 'address'  
      get :show, id: 'address'
      expect(controller.send(:future_step?, :delivery)).to eq true
    end
    
    it "valid params on first_step" do
      allow(controller).to receive(:current_user).and_return user
      session[:last_step] = 'delivery'  
      get :show, id: 'delivery'
      expect(response).to render_template "delivery"
    end
  end
   
  describe "POST #create" do 
      let(:user) {create :user} 
      subject { post :create, checkout: FactoryGirl.attributes_for(:checkout)}  
          
      it "when current_user is guest" do
        allow(controller).to receive(:current_user).and_return user
        expect(subject).to redirect_to new_user_session_path
      end
  end  
end