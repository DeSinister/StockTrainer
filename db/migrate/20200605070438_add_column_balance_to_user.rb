class AddColumnBalanceToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :balance, :decimal, :default => 10000
  end
end
