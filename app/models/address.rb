class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  has_many :shipping_address
  has_many :billing_address
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  
  validates :zip, {  
    length: { maximum: 10 , message: "Zip must be 10 digits"},
    numericality: {only_integer: true, message: "Zip must contain only numbers"}
  }
  
  validates :phone, {  
    length: { maximum: 16 , message: "Phone must be 16 digits"},
    numericality: {only_integer: true, message: "Phone must contain only numbers"}
  }

end
