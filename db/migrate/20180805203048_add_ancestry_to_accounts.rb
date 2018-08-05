class AddAncestryToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :ancestry, :string
    add_index :accounts, :ancestry
  end
end
