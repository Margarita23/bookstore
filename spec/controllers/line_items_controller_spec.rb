require "rails_helper"

RSpec.describe LineItemsController, :type => :controller do
  describe "line_item controller" do
    let(:user) {create :user}
    let(:cart) {create :cart, id: user.id, user_id: user.id}
    let(:book) {create :book }
    let(:line_item) {create :line_item, cart_id: cart.id, book_id: book.id, price: book.price}

    before do
      allow(controller).to receive(:current_user).and_return user
      request.env["HTTP_REFERER"] = "back"
    end

    describe "POST #create" do 
      
      subject { post :create, cart_id: cart.id, line_items: FactoryGirl.attributes_for(:line_item)}  
      
      it "when book is nil" do
        allow(Book).to receive("find_by").and_return nil
        expect(subject).to redirect_to "/"
      end
      
      it "check flash" do
          subject
          expect(flash[:alert]).to eq I18n.t(:books_not_added)
        end 
      
      describe "line_items new quantity is not valid" do 
        
        subject { post :create, cart_id: cart.id, line_items: FactoryGirl.attributes_for(:line_item)}  
        
        before do
          allow(Book).to receive("find_by").and_return book
        end
        it "check flash" do
          allow(controller).to receive(:set_quantity).and_return LineItem.new
          subject
          expect(flash[:alert]).to eq I18n.t(:books_not_added)
        end 
      end
      describe "line_items new quantity is valid" do
        before do
          allow(Book).to receive("find_by").and_return book
          allow(controller).to receive(:set_quantity).and_return(line_item)
        end
        it "flash notice after save" do 
          allow(controller).to receive(:qty_less_books).and_return(I18n.t(:books_added))
          post :create, cart_id: cart.id, :new_quantity => '3' 
          expect(flash[:notice]).to eq I18n.t(:books_added)
        end
        it "new_quantity more than book.quantity" do 
          p = I18n.t(:books_in_store_1) + "#{book.quantity}" + I18n.t(:books_in_store_2)
          allow(controller).to receive(:qty_less_books).and_return p
          post :create, cart_id: cart.id, :new_quantity => '300' 
          expect(flash[:notice]).to eq p
        end
        it "flash alert after save" do 
          allow(controller).to receive(:qty_less_books).and_return(I18n.t(:books_added))
          subject
          expect(flash[:notice]).to eq I18n.t(:books_added)
        end
      end
    end

    describe "DELETE #destroy" do
      subject { delete :destroy, cart_id: cart.id, id: line_item.id }
      it "check path" do
        expect(subject).to redirect_to "back"
      end
      it "deletes the line_item" do
        line_item
        expect{subject}.to change(LineItem, :count).by(-1)
      end
    end
    
    describe "PUT #update" do
      context "valid params" do
        it "check alert" do 
          put :update, id: line_item.id, line_item: FactoryGirl.attributes_for(:line_item), new_quantity: '2'
          expect(flash[:notice]).to eq I18n.t(:quan_changed)
        end
      end

      context "invalid params" do
        it "path after unsuccessful updating  " do 
          expect(put :update, id: line_item.id, line_item: FactoryGirl.attributes_for(:line_item), new_quantity: '240').to redirect_to "back"
        end
        it "check alert" do 
          put :update, id: line_item.id, line_item: FactoryGirl.attributes_for(:line_item), new_quantity: '250'
          expect(flash[:alert]).to eq I18n.t(:quan_not_changed)
        end
      end
      
      describe "method check_quantity return true" do
        subject { put :update, cart_id: cart.id, id: line_item.id, :new_quantity => '4' }
        it "return true" do
          subject
          expect(controller.send(:check_quantity,line_item, book, 2)).to eq true
        end
        it "check_quantity return false" do
          put :update, cart_id: cart.id, id: line_item.id, :new_quantity => '150'
          expect(controller.send(:check_quantity,line_item, book, 150)).to eq false
        end
      end
end

    
    
    
  end
end
