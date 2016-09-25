require 'rails_helper'
RSpec.describe ShippingAddress, type: :model do
  it { should belong_to(:address) }
end
