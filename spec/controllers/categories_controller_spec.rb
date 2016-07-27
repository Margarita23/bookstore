require "rails_helper"
RSpec.describe CategoriesController, :type => :controller do
  describe "GET #show" do
    let!(:category) {FactoryGirl.create :category} 
    let(:user) { create :user }
    
    it "assigns @category" do
      get :show, id: category.id
      assert_equal assigns(:category), category
    end
  end
end