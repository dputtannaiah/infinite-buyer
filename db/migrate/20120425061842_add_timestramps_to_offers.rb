class AddTimestrampsToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :created_at, :datetime
    add_column :offers, :updated_at, :datetime
    add_column :offers, :expire_at, :datetime
  end
end
