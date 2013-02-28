class AddColumnFacebookIdAndRemoveOtherColumnsInUsers < ActiveRecord::Migration
  def up
    remove_column :users, :twitter_screen_name
    remove_column :users, :twitter_display_name

    add_column :users, :facebook_id, :string
  end

  def down
    add_column :users, :twitter_screen_name, :string
    add_column :users, :twitter_display_name, :string

    remove_column :users, :facebook_id
  end
end
