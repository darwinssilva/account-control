require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:origin_account) { FactoryGirl.create(:account, :physical_person, balance: 0) }
  let!(:destination_account) { FactoryGirl.create(:account, :physical_person, balance: 0) }
  let!(:load_transaction) { FactoryGirl.create(:load_transaction, origin_account_id: origin_account.id, origin_account_before_transaction: origin_account.balance, destination_account_id: destination_account.id) }

  describe 'Validations' do
    context ':transaction_type' do
      it 'should be uniq' do should validate_presence_of(:transaction_type) end
      it 'shoud be valid' do should define_enum_for(:transaction_type).with([:charge, :transfer]) end
    end

    context ':value' do
      it 'should be present' do should validate_presence_of(:value) end
      it 'shoud be numericality' do should validate_numericality_of(:value).is_greater_than(0) end
    end

    context ':origin_account_id' do
      it 'should be present' do should validate_presence_of(:origin_account_id) end
      it 'shoud be numericality' do should validate_numericality_of(:origin_account_id) end
    end

    context ':origin_account_before_transaction' do
      it 'should be present' do should validate_presence_of(:origin_account_before_transaction) end
      it 'shoud be numericality' do should validate_numericality_of(:origin_account_before_transaction) end
    end

    context ':destination_account_id' do
      it 'shoud be numericality' do should validate_numericality_of(:destination_account_id) end
    end

    context ':destination_account_before_transaction' do
      it 'shoud be numericality' do should validate_numericality_of(:origin_account_id) end
      it 'allow nil' do should allow_value(nil).for(:destination_account_before_transaction) end
    end
  end

  describe 'Associations' do
    it 'origin_account' do should belong_to(:origin_account).class_name('Account').with_foreign_key(:origin_account_id) end
    it 'destination_account' do should belong_to(:destination_account).class_name('Account').with_foreign_key(:destination_account_id) end
  end
end