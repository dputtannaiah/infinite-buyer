class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.float :amount
      t.integer :user_id
      t.integer :bid_id
      t.text :params
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
