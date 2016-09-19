require 'rails_helper'
RSpec.describe Book, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:category_id) }
  it { should validate_presence_of(:bought) }
  it { should validate_presence_of(:quantity) }
  
  it { should belong_to(:category) }
  it { should belong_to(:author) }
  
  it { should have_many(:ratings) }
  it { should have_many(:line_items) }
  
  let!(:book) {create :book}
  let!(:book_2) {create :book}
  let!(:item) {create :line_item, book_id: book_2.id}
  
  it "not_referenced_by_any_item return true" do
    expect(book.send(:not_referenced_by_any_item)). to eq true
  end
  
  it "not_referenced_by_any_item return false" do
    expect(book_2.send(:not_referenced_by_any_item)). to eq false
  end
end