require 'rails_helper'
RSpec.describe Delivery, type: :model do
  it { should have_many(:orders) }
  it { should validate_uniqueness_of(:method) }
end
