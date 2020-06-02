class CreateUserStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :user_stocks do |t|
      t.references :user
      t.references :stock

      t.timestamps
    end
  end
end
