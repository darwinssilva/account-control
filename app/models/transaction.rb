class Transaction < ApplicationRecord
  enum type: [:load, :transfer, :reverse]

  validates :transactional_code, presence: true,
            uniqueness: true,
            length: { is: 32 }

  validates :type, presence: true,
            inclusion: { in: Transaction.types.keys }

  validates :value, presence: true,
                    numericality: { greater_than: 0 }

  validates :origin_account_id, presence: true,
                              numericality: true

  validates :origin_account_before_transaction, presence: true,
                                                 numericality: { greater_than_or_equal_to: 0 }

  validates :destination_account, numericality: true,
                              allow_nil: { if: Proc.new { |t| t.type == 'load' } }

  validates :destination_account_before_transaction, numericality: { greater_than_or_equal_to: 0 }, allow_nil: { if: Proc.new { |t| t.destination_account.nil? } }

  validates :reversed, inclusion: { in: [true, false] }

  validates :transactional_code_reversed, uniqueness: true, length: { is: 32 }, allow_nil: { if: Proc.new { |t| t.reversed == true } }

  validates_associated :destination_account, :origin_account

  belongs_to :origin_account, class_name: 'Account', foreign_key: 'origin_account_id'
  belongs_to :destination_account, class_name: 'Account', foreign_key: 'destination_account'

  def accounts
    Account.where(id: [self.origin_account_id, self.destination_account])
  end

  def make
  end

  private
  def set_defatul_values
  end

  def registered?
    if Transaction.find_by(transactional_code: self.transactional_code)
      self.errors.add(:transactional_code, message: 'already registered')
    end
  end

  def create_transactional_code
    TransactionHelper::Generator.alphanumerical_code(
      origin_account_id: origin_account_id, type: type, destination_account: destination_account
    )
  end
end