require "rails_helper"

RSpec.describe BooksController, :type => :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end
  
  describe "POST create" do
    let(:book) { create :book }
    it "has baught 0" do
      expect(book.bought).to equal(0)
    end  
  end
  
end