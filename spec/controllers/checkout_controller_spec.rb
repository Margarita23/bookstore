require 'rails_helper'
RSpec.describe CheckoutsController, type: :controller do
  
  describe "GET #show" do
    let(:user) {create :user, guest: false}
    let(:cart) {create :cart, id: user.id, user_id: user.id}
      
    before do
      allow(controller).to receive(:current_user).and_return user
      allow(user).to receive(:cart).and_return cart
    end
    
    describe "first step - address" do
      subject { get :show, id: 'address' }
    
      it "assigns @checkout user_id" do
        session[:checkout] = {}
        subject
        expect(assigns(:checkout).user_id).to eq(user.id)
        session[:checkout] = nil
      end  
    end
  
    describe "second step - delivery" do
      subject { get :show, id: 'delivery' }
    
      it "assigns @checkout " do
        session[:checkout] = {:bill_f_name => 'John', 
          :bill_l_name => 'Dandy', 
          :bill_street => 'Hanty Roude, 12', 
          :bill_city => 'Solt Lake City', 
          :bill_country => 'USA', 
          :bill_zip =>'123456', 
          :bill_phone => '1234567890', 
          :ship_f_name => nil, 
          :ship_l_name => nil, 
          :ship_street => nil, 
          :ship_city => nil, 
          :ship_country => nil, 
          :ship_zip => nil, 
          :ship_phone => nil,
          :same_address => '1' }
        subject
        expect(assigns(:checkout).bill_f_name).to eq('John')
      end
    end
    
    describe "third step - payment" do
      subject { get :show, id: 'payment' }
    
      it "assigns @checkout delivery " do
        session[:checkout] = {:delivery => '2' }
        subject
        expect(assigns(:checkout).delivery).to eq('2')
      end
    end
    
    describe "last step - confirm" do
      subject { get :show, id: 'confirm' }
    
      it "assigns @checkout card_number " do
        session[:checkout] = {
          :card_number => '1234567890123456',
          :card_code => '123',
          :exp_month => '3',
          :exp_year => '2017' }
        subject
        expect(assigns(:checkout).card_number).to eq('1234567890123456')
      end
    end
  end
  
  describe "POST #create" do
    
    let(:user) {create :user, guest: false}
    let(:cart) {create :cart, id: user.id, user_id: user.id}
    let(:delivery) {create :delivery, method: "One Day", price: 15}
    let(:order) {create :order, total_price: "300", delivery_id: delivery.id, number: "AE12345678"}
    
    before do
      allow(controller).to receive(:current_user).and_return user
      allow(user).to receive(:cart).and_return cart
    end
    
    context "with valid attributes" do  
      subject { post :create, checkout: FactoryGirl.attributes_for(:checkout)}
      it "redirects to the home page" do

        allow(:checkout).to receive(:order_id).and_return order.id
        subject
        expect(response).to redirect_to new_order_show_path(assigns(:checkout).order_id)
        #expect{subject}.to change{Order.count}.by(1)
      end
        
      it "saves the new contact in the database" do
      end
    end
    context "with invalid attributes" do
      it "does not save the new contact in the database" do
      end
      it "re-renders the :new template" do
      end
    end
    
    
  end
end




















