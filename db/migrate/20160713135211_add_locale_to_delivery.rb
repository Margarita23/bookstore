class AddLocaleToDelivery < ActiveRecord::Migration
  def change
    add_column :deliveries, :locale, :string
  end
end
