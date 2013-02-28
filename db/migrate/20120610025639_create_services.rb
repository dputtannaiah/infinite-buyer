class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.text :brief_description, :limit => 300
      t.text :detailed_description
      t.text :additional_info, :limit => 350
      t.integer :bid_id
      t.timestamps
    end
  end
end
