class AddPaypalEmailToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :paypal_email, :string

  end
end
