class AddBoughtToBooks < ActiveRecord::Migration
  def change
    add_column :books, :bought, :integer
  end
end
