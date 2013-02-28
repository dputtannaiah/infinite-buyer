class AddOfferTypeToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :offer_type, :integer, :default => 0
  end
end
