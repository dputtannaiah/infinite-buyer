class AddLoggedInAsToUser < ActiveRecord::Migration
  def change
    add_column :users, :logged_in_as, :integer
  end
end
