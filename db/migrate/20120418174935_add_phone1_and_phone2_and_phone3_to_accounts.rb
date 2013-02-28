class AddPhone1AndPhone2AndPhone3ToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :phone1, :string

    add_column :accounts, :phone2, :string

    add_column :accounts, :phone3, :string

  end
end
