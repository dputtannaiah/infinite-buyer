class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :first_name ,:null => false
      t.string :last_name, :null => false
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip, :null => false
      t.integer :search_radius, :null => false
      t.string :phone, :null => false
      t.string :security_question, :null => false
      t.string :security_answer, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end
end
