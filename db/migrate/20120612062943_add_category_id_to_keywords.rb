class AddCategoryIdToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :category_id, :integer
  end
end
