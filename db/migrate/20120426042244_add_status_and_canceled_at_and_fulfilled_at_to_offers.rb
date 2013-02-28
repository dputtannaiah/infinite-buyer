class AddStatusAndCanceledAtAndFulfilledAtToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :status, :string, :limit => 10
    add_column :offers, :canceled_at, :datetime
    add_column :offers, :fullfilled_at, :datetime

  end
end
