class Book < ActiveRecord::Base
  
  validates :title, :price, :category_id, :bought, :quantity, :presence => true
  
  translates :title, :description
  
  belongs_to :category
  belongs_to :author
  has_many :ratings, dependent: :destroy
  has_many :line_items
   
  delegate :first_name, :last_name, to: :author

  before_destroy :not_referenced_by_any_item
  
  has_attached_file :cover, 
                    styles: { small: "64x64", med: "200x300", large: "400x400" }, 
                    :default_url => "http://res.cloudinary.com/nmetau/image/upload/v1459851257/sJ3CT4V_yqfnoq.gif"
  
  validates_attachment_content_type :cover, 
                                    :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  scope :bestsellers, -> { order(bought: :desc).reverse.first(10) }
  
  private
  
  def not_referenced_by_any_item
    line_items.empty?
  end
end
