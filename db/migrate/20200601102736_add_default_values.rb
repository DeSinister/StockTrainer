class AddDefaultValues < ActiveRecord::Migration[6.0]
  def change
    change_column :user_stocks, :quantity, :integer, :default => 0
    change_column :user_stocks, :cprice, :integer, :default => 0

  end
end
