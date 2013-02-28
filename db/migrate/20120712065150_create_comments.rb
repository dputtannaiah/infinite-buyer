class CreateComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.integer  :user_id
      t.text     :body
      t.integer  :post_id
      t.string   :name
      t.string   :website
      t.string   :email
      t.timestamps
    end
  end
end
