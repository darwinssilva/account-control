class TransferTransaction < Transaction
  def make_transaction
    return false unless set_default_values
    return false unless valid_transaction?

    begin
      ActiveRecord::Base.transaction do
        self.origin_account.sake(self.value)
        self.destination_account.deposit(self.value)
        self.save
      end

      raise unless self.errors.messages.blank?  
      self
    rescue
      false
    end
  end

  def set_default_values
    self.origin_account_before_transaction = self.origin_account.balance if origin_account
    self.destination_account_before_transaction = self.destination_account.balance if destination_account
  end

  def valid_transaction?
    self.errors.add(:origin_account, :not_active, message: 'should be active status') unless self.origin_account.valid_account?
    self.errors.add(:accounts, :not_hierarchical, message: 'do not have the same hierarchy') if self.origin_account.root.id != self.destination_account.root.id
    self.errors.add(:destination_account, :matrix, message: 'is an array account can not receive transfer') if self.destination_account.root.id == self.destination_account.id
    self.errors.add(:destination_account, :not_active, message: 'should be active status') unless self.destination_account.valid_account?

    self.errors.messages.blank? ? true : false
  end
end