class RemovePhoneFromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :phone
      end

  def down
    add_column :accounts, :phone, :string
  end
end
