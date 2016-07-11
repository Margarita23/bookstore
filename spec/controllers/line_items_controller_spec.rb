require "rails_helper"

RSpec.describe LineItemsController, :type => :controller do
  describe "line_item controller" do
    let(:user) {create :user, guest: false}
    let(:cart) {create :cart, id: user.id, user_id: user.id}
    let(:book) {create :book }
    let(:line_item) {create :line_item, cart_id: cart.id, book_id: book.id, price: book.price}

    before do
      allow(controller).to receive(:current_user).and_return user
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    describe "POST #create" do
      subject { post :create, cart_id: cart.id}
      before do
        allow(Book).to receive("find").and_return book
      end  
      describe "line_items new quantity is not valid" do 
        before do
          allow_any_instance_of(Cart).to receive_message_chain("line_items.find_by").and_return line_item
        end
        it "check redirected path" do
          subject
          expect(subject).to redirect_to "where_i_came_from"
        end
        it "check flash" do
          subject
          expect(flash[:alert]).to eq "Book can not be add to your cart, please enter information."
        end 
      end
      describe "line_items new quantity is valid" do
        before do
          allow(controller).to receive(:check_nil).and_return(line_item)
          allow(controller).to receive(:less_or_more).and_return(true)
        end
        it "@line_item is nil, price" do
          allow_any_instance_of(Cart).to receive_message_chain("line_items.find_by").and_return line_item
          subject
          expect(assigns(:line_item).price).to eq book.price
        end
        it "flash notice after save" do 
          allow(controller).to receive(:less_or_more).and_return(false)
          post :create, cart_id: cart.id, :new_quantity => '3' 
          expect(flash[:notice]).to eq "Book(s) was(were) added in your cart"
        end
        it "new_quantity more than book.quantity" do 
          post :create, cart_id: cart.id, :new_quantity => '150' 
          expect(flash[:alert]).to eq "Sorry, but the stock only #{book.quantity} book(s). In your basket was(were) added all this book(s)"
        end
        it "flash alert after save" do 
          subject
          expect(flash[:alert]).to eq "Book can not be add to your cart, please enter information."
        end
      end
    end

    describe "DELETE #destroy" do
      subject { delete :destroy, cart_id: cart.id, id: line_item.id }
      it "check path" do
        expect(subject).to redirect_to "where_i_came_from"
      end
      it "deletes the line_item" do
        line_item
        expect{subject}.to change(LineItem, :count).by(-1)
      end
    end

    describe "PUT #update" do
      subject { put :update, cart_id: cart.id, id: line_item.id}
      context "valid params" do
        it "flash" do
          allow(controller).to receive(:check_quantity).and_return(true)
          controller.instance_variable_set(:@quan, 3)
          subject
          expect(flash[:notice]).to eq "Books quantity was changed"
        end
      end

      context "invalid params" do
        it { expect(subject).to redirect_to "where_i_came_from" }
        it "check alert" do 
          subject 
          expect(flash[:alert]).to eq "Books quantity can not change, please enter information."
        end
      end
      
      describe "method check_quantity" do
        subject { put :update, cart_id: cart.id, id: line_item.id, :new_quantity => '4' }
        it "return true" do
          subject
          expect(controller.send(:check_quantity,line_item)).to eq true
        end
        it "return false" do
          put :update, cart_id: cart.id, id: line_item.id, :new_quantity => '150'
          expect(controller.send(:check_quantity,line_item)).to eq false
        end
      end
    end
  end
  

end








