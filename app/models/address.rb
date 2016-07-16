class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  has_many :shipping_address
  has_many :billing_address
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  
  validates :zip, {  
    length: { maximum: 10 , message: I18n.t(:zip_length)},
    numericality: {only_integer: true, message: I18n.t(:zip_only_num)},
    allow_nil: true
  }
  
  validates :phone, {  
    length: { maximum: 16 , message: I18n.t(:phone_length)},
    numericality: {only_integer: true, message: I18n.t(:phone_oly_num)},
    allow_nil: true
  }

end
