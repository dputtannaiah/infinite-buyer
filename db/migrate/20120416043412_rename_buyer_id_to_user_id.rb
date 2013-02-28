class RenameBuyerIdToUserId < ActiveRecord::Migration
  def up
    rename_column :offers, :buyer_id, :user_id
  end

  def down
    rename_column :offers, :user_id, :buyer_id  
  end
end
