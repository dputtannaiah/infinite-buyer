class AddScalingToPrice < ActiveRecord::Migration
  def change
    change_column :offers, :price, :decimal, :precision => 15, :scale => 2
  end
end
