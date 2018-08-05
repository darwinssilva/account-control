class LegalPerson < ApplicationRecord
	validates :cnpj, presence: true,
                 numericality: { only_integer: true },
                 length: { is: 14 }

  validates :company_name, presence: true
  validates :fantasy_name, presence: true

  has_many :accounts, as: :person
end
