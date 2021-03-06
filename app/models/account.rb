class Account < ApplicationRecord
  after_initialize :initial_balance, if: :new_record?
  before_update :cancelled_account_not_update

  enum status: [:cancelled, :active, :blocked]

  validate :valid_ancestry
 	validates :name, presence: true
 	validates :balance, presence: true,
	                	numericality: true

 	validates :status, presence: true,
	                   inclusion: { in: Account.statuses.keys }

 	validates :person, presence: true

 	belongs_to :person, polymorphic: true

 	has_ancestry

  scope :transactions, -> { Transaction.where('origin_account_id = ? || destination_account_id = ?', self.id, self.id) }

 	def initial_balance
    self.balance = 0
    self.status = 'active'
  end

 	def deposit(value)
    return self unless valid_value?(value)
  	self.balance += value
    self.save
	end

  def sake(value)
    if value >= self.balance
      self.errors.add(:value, message: 'should be equal or more than balance')
      return self
    end

    self.balance -= value
    self.save
  end

  def valid_account?
    if self.status == 'cancelled' || self.status == 'blocked'
      errors.add(:account, message: 'can not be transactions or charges when status is canceled or blocked.')
      return false
    end
    return true
  end

  def valid_value?(value)
    if value < 0 
      errors.add(:value, message: 'deve ser maior que 0.')
      return false
    end
    return true
  end

  def valid_ancestry
    return true if ancestry.blank?
    ancestry_account = Account.find_by(id: self.ancestry.split('/').last)
    errors.add(:account, message: 'account ancestral not found') if ancestry_account.blank?

    errors.add(:account, message: 'account ancestral not be the same account') if ancestry_account.id == self.id

    errors.add(:account, message: 'account ancestral can not be your descendant') if ancestry_account.ancestor_ids.include?(self.id)

    self.parent = ancestry_account
    true  
  end

  def cancelled_account_not_update
    account_before_update = Account.find_by(id: self.id)
    errors.add(:account, message: 'account cancelada não pode receber mais atividades.') if account_before_update.status == 'cancelled'
  end
end
