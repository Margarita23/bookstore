class TempOrder < ActiveRecord::Base
  belongs_to :user
  
  has_one :billing_address, :class_name => "Address", :foreign_key => "temp_billing_id"
  has_one :shipping_address, :class_name => "Address", :foreign_key => "temp_shipping_id"
end
