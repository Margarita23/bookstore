class AddAddressIdToBillingAddresses < ActiveRecord::Migration
  def change
    add_reference :billing_addresses, :address, index: true, foreign_key: true
  end
end
