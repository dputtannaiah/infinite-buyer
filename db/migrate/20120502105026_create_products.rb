class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :title
      t.text    :description
      t.string  :brand
      t.string  :model
      t.string  :color
      t.text    :product_details
      t.text    :technical_details
      t.integer :bid_id
      t.timestamps
    end
  end
end
