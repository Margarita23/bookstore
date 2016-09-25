# User model
class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_one :coupon, dependent: :destroy
  has_many :credit_cards, dependent: :destroy

  ratyrate_rater

  has_one :billing_address, class_name: 'Address', foreign_key: 'user_billing_id', dependent: :destroy
  has_one :shipping_address, class_name: 'Address', foreign_key: 'user_shipping_id',  dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.update_attributes(provider: auth.provider, first_name: auth.info.first_name, last_name: auth.info.last_name, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20])
    end
  end
end
