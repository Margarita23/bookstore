require "rails_helper"

RSpec.describe ApplicationController, :type => :controller do
  
  describe "GET #show" do
    let(:user) {create :user}
    
    before do
      request.env["HTTP_REFERER"] = "back"
    end
    
    it "#change_language when user is nil redirect_to back" do
      get :change_language, locale: 'ru'
      expect(response).to redirect_to "back"
    end
    
    it "#change_language redirect_to back" do
      allow(controller).to receive(:current_user) {user}
      get :change_language, locale: 'ru'
      expect(response).to redirect_to "back"
    end
    
    it "#change_language user locale eq 'en' " do
      allow(controller).to receive(:current_user) {user}
      get :change_language, locale: 'en'
      expect(user.locale).to eq "en"
    end
  end
end