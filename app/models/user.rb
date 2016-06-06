class User < ActiveRecord::Base

  has_many :orders
  has_one :cart
  has_many :ratings
  
  has_one :billing_address, :class_name => "Address", :foreign_key => "user_billing_id"
  has_one :shipping_address, :class_name => "Address", :foreign_key => "user_shipping_id"
  
  #accepts_nested_attributes_for :orders, :allow_destroy => true
  #accepts_nested_attributes_for :billing_address, :allow_destroy => true
  #accepts_nested_attributes_for :shipping_address, :allow_destroy => true
  
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :rememberable, 
         :trackable, 
         :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
  
end
