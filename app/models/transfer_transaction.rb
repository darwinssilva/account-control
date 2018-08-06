class TransaferTransaction < Transaction
  def make
    return false if registered?
    return false unless set_default_values
    return false unless valid_transaction?

    begin
      ActiveRecord::Base.transaction do
        self.origin_account.sake(self.value).save
        self.destination_account.deposit(self.value).save
        self.save
      end

      raise unless self.errors.messages.blank?  
      self
    rescue
      false
    end
  end

  private
  def set_default_values
    self.reversed = false
    self.origin_account_before_transaction = self.origin_account.balance if origin_account
    self.destination_account_before_transaction = self.destination_account.balance if destination_account
    self.transactional_code = create_transactional_code
  end

  def valid_transaction?
    self.errors.add(:id, :not_blank, message: 'can not be provided') if self.id
    self.errors.add(:id, :incosistent, message: 'can not transfer to the same account.') if self.destination_account == self.origin_account
    self.errors.add(:origin_account, :blank, message: 'shoud be present') unless self.origin_account
    self.errors.add(:destination_account, :blank, message: 'shoud be present') unless self.destination_account
    self.errors.add(:reversed, :not_false, message: 'shoud be false.') if self.reversed
    self.errors.add(:reversed_transactional_code, :not_blank, message: 'can not be provided') if self.reversed_transactional_code
    self.errors.add(:conta_origem, :not_active, message: 'should be active status') unless self.origin_account.valid_account?

    if self.origin_account && self.destination_account
      self.errors.add(:contas, :not_hierarchical, message: 'do not have the same hierarchy') if self.origin_account.root.id != self.destination_account.root.id
    end

    if self.destination_account
      self.errors.add(:destination_account, :matrix, message: 'is an array account can not receive transfer') if self.destination_account.root.id == self.destination_account.id
      self.errors.add(:destination_account, :not_active, message: 'should be active status') unless self.destination_account.valid_account?
    end

    return true if self.errors.messages.blank?
  end
end