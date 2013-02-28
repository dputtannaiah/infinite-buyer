class RenameColumnNames < ActiveRecord::Migration
  def up
    rename_column :bids, :demand_id, :offer_id
    rename_column :bids, :seller_id, :user_id
  end

  def down
    rename_column :bids, :user_id, :seller_id
    rename_column :bids, :offer_id, :demand_id
  end
end
