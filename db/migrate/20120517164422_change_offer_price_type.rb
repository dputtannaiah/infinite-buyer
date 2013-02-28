class ChangeOfferPriceType < ActiveRecord::Migration
  def up
    change_column :offers, :price, :float
  end

  def down
    change_column :offers, :price, :decimal, :precision => 15, :scale => 2
  end
end
