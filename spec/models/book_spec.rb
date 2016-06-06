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
end