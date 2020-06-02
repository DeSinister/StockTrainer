class AddQuantityPricceToUserStocks < ActiveRecord::Migration[6.0]
  def change
    add_column :user_stocks, :quantity, :integer, :default => 0
    add_column :user_stocks, :cprice, :integer, :default => 0
  end
end
