class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :balance
      t.integer :status
      t.belongs_to :person, polymorphic: true

      t.timestamps
    end
  end
end
