class AddSearchRadiusAndZipToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :search_radius, :integer
    add_column :offers, :zip, :integer

  end
end
