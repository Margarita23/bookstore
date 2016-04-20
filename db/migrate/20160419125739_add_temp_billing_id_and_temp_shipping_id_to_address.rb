class AddTempBillingIdAndTempShippingIdToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :temp_billing_id, :integer
    add_column :addresses, :temp_shipping_id, :integer
  end
end
