require 'rails_helper'

RSpec.describe LineItem, type: :model do
  
  it { should belong_to(:book) }
  it { should belong_to(:cart) }
  it { should validate_presence_of(:quantity) }
  it { should_not allow_value(0).for(:quantity) }
  
end