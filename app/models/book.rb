class Book < ActiveRecord::Base
  validates :title, :price, :category_id, :bought, :quantity, :presence => true
  translates :title, :description
  belongs_to :category
  belongs_to :author
  has_many :ratings, dependent: :destroy
  has_many :line_items
   
  delegate :first_name, :last_name, to: :author

  before_destroy :not_referenced_by_any_item
  
  scope :bestsellers, -> { order(bought: :desc).reverse.first(10) }
  
  private
  
  def not_referenced_by_any_item
    line_items.empty?
  end
end