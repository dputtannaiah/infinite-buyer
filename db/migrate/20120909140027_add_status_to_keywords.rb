class AddStatusToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :status, :string, :default => "active"
  end
end
