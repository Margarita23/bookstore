class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :country
      t.integer :zip, :default => 0
      t.string :phone, :default => 0
      t.integer :user_billing_id
      t.integer :user_shipping_id
      t.integer :order_billing_id
      t.integer :order_shipping_id

      t.timestamps null: false
    end
  end
end
