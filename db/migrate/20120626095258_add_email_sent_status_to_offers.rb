class AddEmailSentStatusToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :expiry_email_sent, :boolean, :default => false
  end
end
