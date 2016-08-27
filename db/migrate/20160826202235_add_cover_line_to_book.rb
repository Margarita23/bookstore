class AddCoverLineToBook < ActiveRecord::Migration
  def change
    add_column :books, :cover_line, :string
  end
end
