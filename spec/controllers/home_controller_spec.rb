require "rails_helper"

RSpec.describe HomeController, :type => :controller do
  
  describe "GET #bestsellers" do
    let(:books) { create_list :book, 4 } 
    
    it "renders the bestsellers template" do
      expect({ :get => "/" }).to route_to(:controller => "home", :action => "bestsellers")
    end
    
    it 'has array of ONLY ten books' do
      get 'bestsellers'
      expect(assigns(:bestsellers)).not_to match_array(books)
    end
  end

  describe "GET #shopping" do
    
    let(:categories) { create_list :category, 2 } 
    let(:some_books) { create_list :book, 2 } 
    
    it "assigns @shopping" do
      get 'shop'
      expect(assigns(:shopping)).to eq some_books
    end
    
    it "assigns @categories_shop" do
      get 'shop'
      expect(assigns(:categories_shop)).to eq categories
    end
    
  end
end