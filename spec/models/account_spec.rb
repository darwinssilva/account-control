require 'rails_helper'

 RSpec.describe Account, type: :model do
  let!(:account) { FactoryGirl.create(:account, :physical_person) }

   describe 'Validações' do

    context ':name' do
      it 'should be present' do
      	should validate_presence_of(:name)
      end
    end

     context ':balance' do
      it 'should be present' do
      	should validate_presence_of(:balance) 
      end

       it 'should be numericality' do
      	should validate_numericality_of(:balance)
      end
    end

     context ':status' do
      it 'should be present' do
      	should validate_presence_of(:status)
      end

       it 'valid status' do
      	should define_enum_for(:status).with(['cancelled', 'active', 'blocked'])
      end
    end
  end
end 