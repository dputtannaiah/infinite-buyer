class CreateDeclinedOffers < ActiveRecord::Migration
  def change
    create_table :declined_offers do |t|
      t.integer :offer_id
      t.integer :user_id
      t.timestamps
    end
  end
end
