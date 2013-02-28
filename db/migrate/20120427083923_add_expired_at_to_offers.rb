class AddExpiredAtToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :expired_at, :datetime
  end
end
