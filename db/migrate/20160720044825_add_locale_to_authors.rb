class AddLocaleToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :locale, :string
  end
end
