class AddAddressIdToShippingAddresses < ActiveRecord::Migration
  def change
    add_reference :shipping_addresses, :address, index: true, foreign_key: true
  end
end
