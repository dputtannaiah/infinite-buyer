class AddColumnNegetiveTextRenameNameToTextInKeywords < ActiveRecord::Migration
  def self.up
    rename_column :keywords, :name, :text
    add_column :keywords, :negative_text, :text
  end

  def self.down
    rename_column :keywords, :text, :name
    remove_column :keywords, :negative_name
  end
end
