require "rails_helper"
RSpec.describe AddressController, :type => :controller do
  describe "PUT#update" do
    let(:user) {create :user}
    let!(:address) {create :address}
    describe "valid attributes" do
      before do
        request.env["HTTP_REFERER"] = "back"
        allow(controller).to receive(:current_user) {user}
        @bill_address = FactoryGirl.create(:address)       
      end 
      it "path after save" do 
        put :update, :id => @bill_address.id, address: FactoryGirl.attributes_for(:address)
        expect(assigns(:address)).to eq(@bill_address) 
      end
      
      it "check flash notice when valid params" do
        allow_any_instance_of(Address).to receive(:update) {@bill_address}
        put :update, :id => address.id, address: @bill_address
        expect(flash[:notice]).to eq I18n.t(:'addresses.updated')
      end
    end
    
    describe "invalid attributes" do
      let!(:user_2) {create :user}
      before do
        request.env["HTTP_REFERER"] = "back"
        allow(controller).to receive(:current_user) {user_2}
        @address = {first_name: "Jine", last_name: "Derty"}
        @bill_address = FactoryGirl.create(:address)
        put :update, :id => @bill_address.id, address: @address
      end
      it "invalid updating data" do 
        expect(@bill_address).to_not eq @address 
      end
      
      it "check flash alert when invalid params" do
        expect(flash[:alert]).to eq I18n.t(:'addresses.not_updated')  
      end
      it "private address_params" do 
        expect(controller.send(:address_params)).to eq({first_name: nil, last_name: nil, street: nil, city: nil, country: nil, zip: nil, phone: nil})
      end
    end
  end
end