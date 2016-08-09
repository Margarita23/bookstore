class Rating < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
  ratyrate_rateable "grade"
  
  validates :review, length: { maximum: 500, message: I18n.t(:review_length) }
  validates :review, presence: true
  validates :headline, presence: true
  validates_presence_of :grade
  
  scope :checking, -> { where(admin_checking: true) }
end
