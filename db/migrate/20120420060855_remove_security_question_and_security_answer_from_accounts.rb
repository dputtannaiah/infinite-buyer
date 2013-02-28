class RemoveSecurityQuestionAndSecurityAnswerFromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :security_question
    remove_column :accounts, :security_answer
  end

  def down
    add_column :accounts, :security_answer, :string
    add_column :accounts, :security_question, :string
  end
end
