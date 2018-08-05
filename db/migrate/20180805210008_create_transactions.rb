class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :transactional_code
      t.integer :type
      t.decimal :value
      t.belongs_to :origin_account
      t.decimal :origin_account_before_transaction
      t.belongs_to :destination_account
      t.decimal :destination_account_before_transaction
      t.boolean :reversed
      t.string :reversed_transactional_code

      t.timestamps
    end
  end
end
