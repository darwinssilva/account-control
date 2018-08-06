class Transaction < ApplicationRecord
  enum transaction_type: [:charge, :transfer]
  validates :transaction_type, presence: true

  validates :value, presence: true,
                    numericality: { greater_than: 0 }

  validates :origin_account_id, presence: true,
                                numericality: true

  validates :origin_account_before_transaction, presence: true,
                                                numericality: { greater_than_or_equal_to: 0 }

  validates :destination_account_id, numericality: true,
                                     allow_nil: { if: Proc.new { |t| t.transaction_type == 'charge' } }

  validates :destination_account_before_transaction, numericality: { greater_than_or_equal_to: 0 }, allow_nil: { if: Proc.new { |t| t.destination_account.nil? } }

  validates_associated :destination_account, :origin_account

  belongs_to :origin_account, class_name: 'Account', foreign_key: 'origin_account_id'
  belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account_id'

  def accounts
    Account.where(id: [self.origin_account_id, self.destination_account])
  end

  def make; end

  private
  def set_defatul_values; end
end