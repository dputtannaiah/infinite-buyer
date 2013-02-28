class AddTypeToBids < ActiveRecord::Migration
  def change
    add_column :bids, :type, :boolean
  end
end
