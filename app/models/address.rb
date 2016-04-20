class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :temp_order
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
end
