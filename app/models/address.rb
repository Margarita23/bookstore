class Address < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :order
  has_many :shipping_address
  has_many :billing_address
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
end
