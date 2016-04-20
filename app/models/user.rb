class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :orders
  has_one :cart
  has_one :temp_order
  
  has_one :billing_address, :class_name => "Address", :foreign_key => "user_billing_id"
  has_one :shipping_address, :class_name => "Address", :foreign_key => "user_shipping_id"
  
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :rememberable, 
         :trackable, 
         :validatable
end
