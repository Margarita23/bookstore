require 'rails_helper'
RSpec.describe Address, type: :model do
  it { should accept_nested_attributes_for(:shipping_address) }
  it { should accept_nested_attributes_for(:billing_address) }
end