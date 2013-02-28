class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.text :name
      t.integer :user_id

      t.timestamps
    end
  end
end
