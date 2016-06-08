require "rails_helper"

RSpec.describe BooksController, :type => :controller do
  
  describe "POST create" do
    let(:book) { create :book }
    it "has baught 0" do
      expect(book.bought).to equal(0)
    end  
  end
  
end