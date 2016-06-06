require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:orders) }
  it { should have_many(:ratings) }
  it { should have_one(:cart) }
  it { should have_one(:billing_address) }
  it { should have_one(:shipping_address) }

  
end