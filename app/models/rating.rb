class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
  validates :review, length: { maximum: 500, message: "Your review too match long" }
  validates :review, presence: true
  validates :headline, presence: true
  

end
