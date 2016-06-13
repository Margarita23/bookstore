class AddAdminsCheckingToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :admin_checking, :boolean, :default => false
  end
end
