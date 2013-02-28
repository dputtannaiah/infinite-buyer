class Add48HrsEmailSentField < ActiveRecord::Migration
  def change
    rename_column :offers, :expiry_email_sent, :expiry_email_sent_48
    add_column :offers, :expiry_email_sent_24, :boolean, :default => false
  end

end
