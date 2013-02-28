class AddOtherSubCategories < ActiveRecord::Migration
  def up
#    Rake::Task['populate:other-categories'].invoke
#    category = Category.find_by_name("Birthday Card")
#    category.children.create(:name => 'Dad', :category_type => Category::CategoryType::PRODUCT)
#    category.children.create(:name => 'Friend', :category_type => Category::CategoryType::PRODUCT)
#    category.children.create(:name => 'Grand Parents', :category_type => Category::CategoryType::PRODUCT)
#    category.children.create(:name => 'Mom', :category_type => Category::CategoryType::PRODUCT)
#    category.children.create(:name => 'Sibling', :category_type => Category::CategoryType::PRODUCT)
#    category.children.create(:name => 'Spouse', :category_type => Category::CategoryType::PRODUCT)
  end

  Category::CategoryType::PRODUCT

  def down
  end
end
