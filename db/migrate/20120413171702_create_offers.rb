class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :text
      t.integer :buyer_id
      t.float :price
    end
  end
end
