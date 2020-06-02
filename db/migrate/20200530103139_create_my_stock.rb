class CreateMyStock < ActiveRecord::Migration[6.0]
  def change
    create_table :my_stocks do |t|
      t.references :user_stocks
      t.integer :quantity
      t.integer :cprice
      t.timestamps
    end
  end
end
