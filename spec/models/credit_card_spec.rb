require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  
  it { should have_many(:orders) }
  it { should validate_uniqueness_of(:number) }
  
end