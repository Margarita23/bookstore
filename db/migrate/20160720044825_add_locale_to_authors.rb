class AddLocaleToAuthors < ActiveRecord::Migration
  def change
    add_column :authors, :locale, :string, default: 'en'
  end
end
