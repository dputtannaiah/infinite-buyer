class ChangeZipToStringType < ActiveRecord::Migration
  def up
    change_column :accounts, :zip, :string, :limit => 5
  end

  def down
    change_column :accounts, :zip, :integer
  end
end
