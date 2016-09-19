class Author < ActiveRecord::Base
  has_many :books
  translates :first_name, :last_name, :biography
end