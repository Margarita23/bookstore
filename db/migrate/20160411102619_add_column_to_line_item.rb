class AddColumnToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :quantity, :integer
    add_column :line_items, :price, :decimal
  end
end
