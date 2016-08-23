require "rails_helper"

RSpec.describe AuthorsController, :type => :controller do
  
  describe "GET#show" do
    let(:user) {create :user}
    let!(:author) {create :author}
    
    before do
      request.env["HTTP_REFERER"] = "back"
    end
    it "#show  response return author`s render template" do
      allow(controller).to receive(:current_user) {user}
      get :show, id: author.id
      expect(response).to render_template(:show)
    end
    
    it "assigns(:author)" do
      allow(controller).to receive(:current_user) {user}
      get :show, id: author.id
      expect(assigns(:author)).to eq author
    end
    
    
  end
end