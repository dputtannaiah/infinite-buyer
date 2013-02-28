class ChangeStatusDatatype < ActiveRecord::Migration
  def up
    change_column :keywords, :status, :boolean , :default => true
  end

  def down
    change_column :keywords, :status, :string , :default => "active"
  end
end
