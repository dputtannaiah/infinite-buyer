namespace 'fix' do
  desc 'fix old categories to new categories'
  task 'categories' => :environment do
    IO.readlines("#{Rails.root}/db/category_mappings_old_to_new.txt").each do |names|
      old_id = names.split(',')[0].strip
      new_id = names.split(',')[1].strip

      old_category = Category.with_deleted.find old_id
      new_category = Category.find new_id

      p old_category.ancestors.map(&:name).join(" ====> ") + " ====> " + old_category.name + "  +++++++++++++++  " + new_category.ancestors.map(&:name).join(" ====> ") + " ====> "+ new_category.name

      #update records
      SellerCategory.where(:category_id => old_category.id).update_all "category_id = #{new_category.id}"
      Keyword.where(:category_id => old_category.id).update_all "category_id = #{new_category.id}"
    end

  end
end
