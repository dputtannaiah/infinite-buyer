class RemoveColumnUserIdAddColumnsToBlogComments < ActiveRecord::Migration
  def up
    remove_column :blog_comments, :user_id
    add_column :blog_comments, :admin_id, :integer
    add_column :blog_comments, :reviewed_at, :datetime
  end

  def down
    add_column :blog_comments, :user_id, :integer
    remove_column :blog_comments, :admin_id
    remove_column :blog_comments, :reviewed_at
  end
end
