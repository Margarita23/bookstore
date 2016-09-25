require 'rails_helper'
RSpec.describe BooksController, type: :controller do
  describe 'GET #show' do
    let(:book) { create :book }
    let(:ratings) { FactoryGirl.create_list :rating, 2 }
    let(:rating) { create :rating, headline: 'Best book', review: 'Cool', book_id: book.id, grade: 3, admin_checking: true }

    it 'assigns @ratings when not checking by admin' do
      get :show, id: book.id
      expect(assigns(:ratings)).to eq []
    end

    it 'assigns @ratings' do
      get :show, id: book.id
      expect(assigns(:ratings)).to eq [rating]
    end
  end
end
