require "rails_helper"
RSpec.describe HomeController, :type => :controller do
  describe "GET #show" do 
    
    it "bestsellers path" do
      get :bestsellers
      expect(response).to render_template :bestsellers
    end
    it "shop path" do
      get :shop
      expect(response).to render_template :shop
    end
    
  end
end