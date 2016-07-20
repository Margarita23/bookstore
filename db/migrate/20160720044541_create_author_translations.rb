class CreateAuthorTranslations < ActiveRecord::Migration
  def up
    Author.create_translation_table!({
      first_name: :string,
      last_name: :string,
      biography: :text
    }, {
      migrate_data: true
    })
  end

  def down
    Author.drop_translation_table! migrate_data: true
  end
end
