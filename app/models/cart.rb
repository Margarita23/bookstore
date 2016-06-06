class Cart < ActiveRecord::Base  
  has_many :line_items, dependent: :destroy
  belongs_to :user
  has_attached_file :image, 
                    styles:{icon:"32x32"}, 
                    :default_url => "http://res.cloudinary.com/nmetau/image/upload/c_scale,h_32,w_32/v1457165066/bookshop/basket.png"
end
