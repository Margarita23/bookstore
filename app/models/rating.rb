class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
  validates :review, length: { maximum: 500, message: I18n.t(:review_length) }
  validates :review, presence: true
  validates :headline, presence: true
  
  scope :books_ratings, -> { where("admin_checking = true") }

end
