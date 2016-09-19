class Delivery < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  validates :method, :price, presence: true
  validates :method, uniqueness: true
  translates :method
end