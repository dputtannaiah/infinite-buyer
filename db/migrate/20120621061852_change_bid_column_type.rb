class ChangeBidColumnType < ActiveRecord::Migration
  def change
    rename_column :bids, :type, :bid_type
  end
end
