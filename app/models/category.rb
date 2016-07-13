class Category < ActiveRecord::Base
  has_many :books
  validates :title, uniqueness: true
  translates :title
end
