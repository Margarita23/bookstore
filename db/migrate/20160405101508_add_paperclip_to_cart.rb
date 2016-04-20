class AddPaperclipToCart < ActiveRecord::Migration
  def change
    add_attachment :carts, :image
  end
end
