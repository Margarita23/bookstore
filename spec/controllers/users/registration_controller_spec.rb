require "rails_helper"

RSpec.describe BooksController, :type => :controller do
  
  describe "GET #show" do
    
    let(:user) {create :user}
    let(:book) {create :book}
    let(:ratings) {FactoryGirl.create_list :rating, 2} 
      
  #  before do
   #   allow(controller).to receive(:current_user).and_return user
  #  end
   
    it "assigns @ratings as books ratings" do
      allow_any_instance_of(Book).to receive_message_chain("ratings.where").and_return ratings
      get :show, id: book.id
      expect(assigns(:ratings)).to eq ratings
    end
  end
end