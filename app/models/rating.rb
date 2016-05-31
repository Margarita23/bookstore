class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
  ratyrate_rateable "grade"
end
