class Cart < ActiveRecord::Base  
  has_many :line_items, dependent: :destroy
  has_one :coupon
  belongs_to :user
  has_attached_file :image, 
                    styles:{icon:"32x32"}, 
                    :default_url => "http://res.cloudinary.com/nmetau/image/upload/c_scale,h_32,w_32/v1457165066/bookshop/basket.png"
  
  def update_items_quantity(ids_with_quantity)
    @items_ids = ids_with_quantity.keys
    @items_ids.each do |item_id|
      line_item = LineItem.find_by(id: item_id.to_i)
      line_item.update_attributes(quantity: ids_with_quantity[:"#{item_id}"])
    end
  end
  
end
