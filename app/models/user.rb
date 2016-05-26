class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :orders
  has_one :cart
  
  has_one :billing_address, :class_name => "Address", :foreign_key => "user_billing_id"
  has_one :shipping_address, :class_name => "Address", :foreign_key => "user_shipping_id"
  
  accepts_nested_attributes_for :orders, :allow_destroy => true
  accepts_nested_attributes_for :billing_address, :allow_destroy => true
  accepts_nested_attributes_for :shipping_address, :allow_destroy => true
  
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :rememberable, 
         :trackable, 
         :validatable
  
end
