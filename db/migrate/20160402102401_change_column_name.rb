class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :orders, :completed, :completed_date
  end
end
