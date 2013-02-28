class CreatePosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.integer  :admin_id
      t.text     :body
      t.string   :title
      t.integer  :views,      :default => 0
      t.datetime :deleted_at
      t.string   :avatar
      t.string   :slug
      t.timestamps
    end
  end
end

