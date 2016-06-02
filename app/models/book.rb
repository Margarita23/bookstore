class Book < ActiveRecord::Base
  
  validates :title, :price, :category_id, :bought, :presence => true
  
  belongs_to :category
  belongs_to :author
  belongs_to :cart
  has_many :ratings
  has_one :order_item
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  has_attached_file :cover, styles: { small: "64x64", med: "200x300", large: "400x400" }, :default_url => "http://res.cloudinary.com/nmetau/image/upload/v1459851257/sJ3CT4V_yqfnoq.gif"
  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  private
  
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        return false
      end
    end
end
