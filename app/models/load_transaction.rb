class LoadTransaction < Transaction
  def make
    return false if registered?
    return false unless set_default_values
    return false unless valid_transaction?

    begin
      ActiveRecord::Base.transaction do
        self.origin_account.deposit(self.value).save
        self.save
      end

      raise unless self.errors.messages.blank?
      self
    rescue
      self.errors.messages.merge(self.origin_account.errors.messages)
      false
    end
  end

  private
    def set_default_values
      self.reverse = false
      self.origin_account_before_transaction = self.origin_account.balance if origin_account_id
      self.transactional_code = create_transactional_code
    end

    def transacao_valida?
      self.errors.add(:id, :not_blank, message: 'can not be provided.') if self.id
      self.errors.add(:destination_account_id, :not_blank, message: 'can not be provided.') if self.destination_account_id
      self.errors.add(:destination_account_before_transaction, :not_blank, message: 'can not be provided.') if self.destination_account_before_transaction
      self.errors.add(:reversed, :not_false, message: 'shoud be false') if self.reversed
      self.errors.add(:reversed_transactional_code, :not_blank, message: 'can not be provided.') if self.reversed_transactional_code
      self.errors.add(:origin_account, :not_active, message: 'shoud be active status') unless self.origin_account.valid_account?

      return true if self.errors.messages.blank?
      false
    end
end