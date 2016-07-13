class CreateDeliveryTranslations < ActiveRecord::Migration
  def up
    Delivery.create_translation_table!({
      method: :string
    }, {
      migrate_data: true
    })
  end

  def down
    Delivery.drop_translation_table! mig
  end
end
