require 'rails_helper'

 RSpec.describe LegalPerson, type: :model do

  let!(:legal_person) { FactoryGirl.create(:legal_person) }

   describe 'Validations' do

    context ':cnpj' do
      it 'should be present' do
        should validate_presence_of(:cnpj)
      end

       it 'should be numericality' do 
        should validate_numericality_of(:cnpj).only_integer
      end

       it 'should be 14 characters' do 
        should validate_length_of(:cnpj).is_equal_to(14)
      end
    end

    context ':company_name' do
      it 'should be present' do 
        should validate_presence_of(:company_name)
      end
    end

     context ':fantasy_name' do
      it 'should be present' do 
        should validate_presence_of(:fantasy_name)
      end
    end
  end
end 