class AddColumnCategoryTypeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :category_type, :integer, :limit => 2, :default => 0
  end
end
