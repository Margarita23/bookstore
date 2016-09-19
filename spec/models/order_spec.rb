require 'rails_helper'
RSpec.describe Order, type: :model do
  it { should have_many(:line_items) }
  it { should belong_to(:user) }
  it { should belong_to(:delivery) }
  it { should belong_to(:credit_card) }
  it { should have_one(:billing_address) }
  it { should have_one(:shipping_address) }
  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:delivery_id) }
  it { should validate_presence_of(:number) }
end