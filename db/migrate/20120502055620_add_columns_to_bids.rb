class AddColumnsToBids < ActiveRecord::Migration
  def change
    add_column :bids, :shipping, :float
  end
end
