class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :demand_id
      t.integer :seller_id
      t.float :price
      t.datetime :expires_at

      t.timestamps
    end
  end
end
