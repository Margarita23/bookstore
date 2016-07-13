class AddLocaleToBooks < ActiveRecord::Migration
  def change
    add_column :books, :locale, :string
  end
end
