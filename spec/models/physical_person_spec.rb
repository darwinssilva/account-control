require 'rails_helper'

 RSpec.describe PhysicalPerson, type: :model do
  let!(:physical_person) { FactoryGirl.create(:physical_person) }

   describe 'Validations' do

    context ':cpf' do
      it 'should be present' do
        should validate_presence_of(:cpf)
      end

       it 'should be numericality' do 
        should validate_numericality_of(:cpf).only_integer
      end

       it 'should be 11 characters' do 
        should validate_length_of(:cpf).is_equal_to(11)
      end
    end

     context ':name' do
      it 'should be present' do 
        should validate_presence_of(:name)
      end
    end

     context ':birthdate' do
      it 'should be present' do 
        should validate_presence_of(:birthdate)
      end
    end
  end
end 