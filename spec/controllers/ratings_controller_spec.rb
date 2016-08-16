require "rails_helper"
RSpec.describe RatingsController, :type => :controller do
  describe "GET #show" do
    let(:book) {create :book}
    let(:rating) {create :rating, book_id: book.id }
    it "assigns @rating" do
      get :show, book_id: book.id, id: rating.id
      expect(assigns(:rating)).to eq rating 
    end
  end
  
  describe "GET #new" do
    let(:book) {create :book}
    let(:user) {create :user}
    it "user is member" do
      allow(controller).to receive(:current_user).and_return user
      get :new, book_id: book.id
      expect(response).to render_template(:new)
    end
    
    it "user is guest" do
      get :new, book_id: book.id
      expect(flash[:alert]).to eq "You are not authorized to access this page."
    end
  end
  
  describe "POST #create" do
    let(:user) {create :user}
    let(:book) {create :book}
     before do
        allow(controller).to receive(:current_user).and_return user
      end
    context "with valid attributes" do
      it "saves the new rating in the database" do
        expect{
          post :create, book_id: book.id, rating: {headline: "Good book", review: "Buy it!", book_id: book.id, user_id: user.id}, score: 3
        }.to change(Rating,:count).by(1)
      end
      it "redirects to the book page" do
        post :create, book_id: book.id, rating: {headline: "Good book", review: "Buy it!", book_id: book.id, user_id: user.id}, score: 3
        expect(response).to redirect_to book_path(book.id)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new rating in the database" do
        expect{
          post :create, book_id: book.id, rating: {headline: "Good book", review: "Buy it!", book_id: book.id, user_id: user.id}
        }.to_not change(Rating,:count)
      end
      it "re-renders the :new template" do
        post :create, book_id: book.id, rating: {headline: "Good book", review: "Buy it!", book_id: book.id, user_id: user.id}
        expect(response).to redirect_to new_book_rating_path(book.id)
      end
    end
  end
end