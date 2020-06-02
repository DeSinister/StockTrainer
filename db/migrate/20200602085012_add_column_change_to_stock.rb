class AddColumnChangeToStock < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :change, :decimal, :default => 0
    change_column :user_stocks, :cprice, :decimal, :default => 0
  end
end
