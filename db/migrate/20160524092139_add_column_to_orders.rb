class AddColumnToOrders < ActiveRecord::Migration
 def change
   add_column :orders, :delivery_id, :integer
  end
end
