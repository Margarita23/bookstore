require 'rails_helper'
RSpec.describe Cart, type: :model do
  
  it { should have_many(:line_items).dependent(:destroy) }
  it { should belong_to(:user) }
  
  let(:user) {create :user}
  let(:cart) {create :cart, user_id: user.id}
  let(:items) {create_list :line_item, 2, cart_id: cart.id}
  
  it "update_items_quantity return true" do
    ids = {"#{items.first.id}" => "3", "#{items.last.id}" => "7"}
    expect(cart.send(:update_items_quantity, ids)). to eq ["#{items.first.id}", "#{items.last.id}"]
  end
end