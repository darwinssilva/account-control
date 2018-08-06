class LoadTransaction < Transaction
  def make_transaction
    return false unless set_default_values
    return false unless valid_transaction?

    begin
      ActiveRecord::Base.transaction do
        self.origin_account.deposit(self.value)
        self.save
      end

      raise unless self.errors.messages.blank?
      self
    rescue
      self.errors.messages.merge(self.origin_account.errors.messages)
      false
    end
  end

  def set_default_values
    self.origin_account_before_transaction = self.origin_account.balance if origin_account_id
  end

  def valid_transaction?
    self.errors.add(:origin_account, :not_active, message: 'shoud be active status') unless self.origin_account.valid_account?

    self.errors.messages.blank? ? true : false
  end
end