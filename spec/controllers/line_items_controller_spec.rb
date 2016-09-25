require 'rails_helper'
RSpec.describe LineItemsController, type: :controller do
  describe 'line_item controller' do
    let(:user) { create :user }
    let(:cart) { create :cart, id: user.id, user_id: user.id }
    let(:book) { create :book }
    let(:line_item) { create :line_item, cart_id: cart.id, book_id: book.id, price: book.price }

    before do
      allow(controller).to receive(:current_user).and_return user
      request.env['HTTP_REFERER'] = 'back'
    end

    describe 'POST #create' do
      subject { post :create, cart_id: cart.id, line_items: FactoryGirl.attributes_for(:line_item) }
      it 'when book is nil' do
        allow(Book).to receive('find_by').and_return nil
        expect(subject).to redirect_to '/'
      end
      it 'check flash' do
        subject
        expect(flash[:alert]).to eq I18n.t(:books_not_added)
      end
      describe 'line_items new quantity is not valid' do
        subject { post :create, cart_id: cart.id, line_items: FactoryGirl.attributes_for(:line_item) }
        before do
          allow(Book).to receive('find_by').and_return book
        end
        it 'check flash' do
          subject
          expect(flash[:alert]).to eq I18n.t(:books_not_added)
        end
      end

      describe 'line_items new quantity is valid' do
        before do
          allow(Book).to receive('find_by').and_return book
        end
        it 'flash notice after save' do
          allow(SetLessQuantityService).to receive_message_chain('new.call').and_return I18n.t(:books_added)
          post :create, cart_id: cart.id, new_quantity: '3'
          expect(flash[:notice]).to eq I18n.t(:books_added)
        end
        it 'new_quantity more than book.quantity' do
          p = I18n.t(:books_in_store_1) + book.quantity.to_s + I18n.t(:books_in_store_2)
          allow(SetLessQuantityService).to receive_message_chain('new.call').and_return p
          post :create, cart_id: cart.id, new_quantity: '300'
          expect(flash[:notice]).to eq p
        end
        it 'flash alert if @line_item is nil' do
          allow(ItemWithCheckingQuantityService).to receive_message_chain('new.call').and_return(nil)
          subject
          expect(flash[:alert]).to eq I18n.t(:books_not_added)
        end
        it 'flash alert after save' do
          allow(ItemWithCheckingQuantityService).to receive_message_chain('new.call').and_return p
          allow(assigns(:line_item)).to receive(:save) { false }
          subject
          expect(flash[:alert]).to eq I18n.t(:books_not_added)
        end
      end
    end

    describe 'DELETE #destroy' do
      subject { delete :destroy, cart_id: cart.id, id: line_item.id }
      it 'check path' do
        expect(subject).to redirect_to 'back'
      end
      it 'deletes the line_item' do
        line_item
        expect { subject }.to change(LineItem, :count).by(-1)
      end
    end
  end
end
