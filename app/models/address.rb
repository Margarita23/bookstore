# Address
class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  has_many :shipping_address, dependent: :destroy
  has_many :billing_address, dependent: :destroy
  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :street, presence: true, on: :update
  validates :city, presence: true, on: :update
  validates :country, presence: true, on: :update
  validates :zip, presence: true, on: :update
  validates :phone, presence: true, on: :update
end
