require "rails_helper"
RSpec.describe AddressController, :type => :controller do
  describe "PUT #update" do
    let(:address) {create :address}
      describe "valid attributes" do
        before do
          allow(Address).to receive(:find).and_return address
          @bill_address = FactoryGirl.create(:address)
          put :update, :id => @bill_address.id, address: FactoryGirl.attributes_for(:address)
          @bill_address.reload
        end
        it "save valid updating data" do 
          expect(@bill_address).to eq address 
        end      
      end
    
      describe "invalid attributes" do
        before do
          @address = {first_name: "Jine", last_name: "Derty"}
          allow(Address).to receive(:find).and_return @address
          @bill_address = FactoryGirl.create(:address)
          put :update, :id => @bill_address.id, address: @address
          @bill_address.reload
        end
        it "invalid updating data" do 
          expect(@bill_address).to_not eq @address 
        end
      end  
  end
end