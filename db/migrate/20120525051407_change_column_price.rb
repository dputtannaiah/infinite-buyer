class ChangeColumnPrice < ActiveRecord::Migration
  def up
    change_column :offers, :price, :decimal, :precision => 9, :scale => 2
    change_column :bids, :price, :decimal, :precision => 9, :scale => 2
    change_column :bids, :shipping, :decimal, :precision => 9, :scale => 2
  end

  def down
    change_column :bids, :shipping, :float
    change_column :bids, :price, :float
    change_column :offers, :price, :float
  end
end
