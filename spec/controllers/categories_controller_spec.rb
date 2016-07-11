require "rails_helper"

RSpec.describe CategoriesController, :type => :controller do
  
  describe "GET #show" do
    
    let(:user) { create :user } 
    let(:categories) { FactoryGirl.create_list :category, 2 } 
    
     before do
      allow(controller).to receive(:current_user).and_return user
    end
   
    it "assigns @categories" do
      get :show, id: categories.first.id
      expect(assigns(:categories)).to eq categories
    end
    
    it "renders the show template" do
      get :show, id: categories.first.id
      expect(response).to render_template("show")
    end
    
  end
end
