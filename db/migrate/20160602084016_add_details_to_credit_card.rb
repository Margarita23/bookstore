class AddDetailsToCreditCard < ActiveRecord::Migration
  def change
    add_column :credit_cards, :number, :string
    add_column :credit_cards, :month, :string
    add_column :credit_cards, :year, :string
    add_column :credit_cards, :cvv, :string
    add_reference :credit_cards, :user, index: true, foreign_key: true
  end
end
