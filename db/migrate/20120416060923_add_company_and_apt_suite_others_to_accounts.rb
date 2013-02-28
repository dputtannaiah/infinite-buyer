class AddCompanyAndAptSuiteOthersToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :company, :string
    add_column :accounts, :apt_suite_others, :string
  end
end
