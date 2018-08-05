class PhysicalPerson < ApplicationRecord
	validates :cpf, presence: true,
									numericality: { only_integer: true },
									length: { is: 11 }

 	validates :name, presence: true
 	validates :birthdate, presence: true

 	has_many :accounts, as: :person
end
