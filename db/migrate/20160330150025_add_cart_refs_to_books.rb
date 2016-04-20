class AddCartRefsToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :cart, index: true, foreign_key: true
  end
end
