class ReverseTransaction < Transaction
  def make
    return false if registered?
    return false unless set_default_values
    @reverse_transaction
     = Transaction.find_by(transactional_code: self.reversed_transactional_code)

    begin
      ActiveRecord::Base.transaction do
        case @reverse_transaction
          .type
          when 'load' then
            return false unless valid_load_reverse_transaction?
            make_load_reserve
          when 'transferencia' then
            return false unless valid_reverse_transfer_transaction?
            make_tranfer_reverse
          else
            @reverse_transaction.errors.add(:type, :valid, message: 'transaction to be reversed must have valid type')
          return false
        end
      end

      raise unless self.errors.messages.blank? && @reverse_transaction.errors.messages.blank?
      self
      rescue
      self.errors.messages.merge!(@reverse_transaction.errors.messages)
      false
    end
  end

  private
  def set_default_values
    self.reversed = false
    self.origin_account_id = self.origin_account_before_transaction = self.destination_account_id = self.destination_account_before_transaction = nil
    unless self.reversed_transactional_code
      self.errors.add(:reversed_transactional_code, :blank, message: 'must be provided')
      return false
    end

    @reverse_transaction = Transaction.find_by(transactional_code: self.reversed_transactional_code)

    if @reverse_transaction.blank?
      self.errors.add(:reversed_transactional_code, :invalid)
    end

    if @reverse_transaction.reversed == true
      self.errors.add(:reversed, :not_false, message: 'must be false in transaction to be reversed.')
    end

    if @reverse_transaction.type == 'reverse'
      self.errors.add(:type, :invalid, message: 'should not be reversed in transaction to be reversed.')
    end

    self.value = @reverse_transaction.value
    self.origin_account_id = @reverse_transaction.origin_account_id
    self.origin_account_before_transaction = @reverse_transaction.origin_account.balance if @reverse_transaction.origin_account_id
    self.destination_account_id = @reverse_transaction.destination_account_id
    self.destination_account_before_transaction = @reverse_transaction.destination_account.balance if @reverse_transaction.destination_account_id
    self.transactional_code = create_transactional_code
  end

  def valid_load_reverse_transaction?
    self.errors.add(:reversed_transactional_code, :blank, message: 'must be provided.') unless self.reversed_transactional_code
    self.errors.add(:id, :not_blank, message: 'can not be provided') if self.id
    self.errors.add(:origin_account, :blank, message: 'shoud be present') unless self.origin_account_id
    self.errors.add(:reversed, :not_false, message: 'should be false.') if self.reversed == 1

    return true if self.errors.messages.blank?
  end

  def make_load_reserve
    @origin_account = self.origin_account
    @origin_account.reverse_sake(self.value)
    @origin_account.save if @origin_account.errors.messages.blank?
    self.save
    @reverse_transaction.reversed = true
    @reverse_transaction.save
    self.errors.messages.merge!(@origin_account.errors.messages)
  end

  def valid_reverse_transfer_transaction?
    self.errors.add(:reversed_transactional_code, :blank, message: 'must be provided.') unless self.reversed_transactional_code
    self.errors.add(:id, :not_blank, message: 'can not be provided') if self.id
    self.errors.add(:id, :incosistent, message: 'can not transfer to the same account') if self.origin_account_id == self.destination_account_id
    self.errors.add(:origin_account, :blank, message: 'should be present') unless self.origin_account_id
    self.errors.add(:destination_account, :blank, message: 'should be present') unless self.destination_account_id
    self.errors.add(:reversed, :not_false, message: 'should be false') if self.reversed == 1

    return true if self.errors.messages.blank?
  end

  def make_tranfer_reverse
    self.destination_account.reverse_sake(self.value).save
    self.origin_account.deposit(self.value).save
    self.save

    @reverse_transaction.reversed = true
    @reverse_transaction.save
  end
end