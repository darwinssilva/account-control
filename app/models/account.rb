class Account < ApplicationRecord
	enum status: ['cancelled', 'active', 'blocked']

 	validates :name, presence: true
 	validates :balance, presence: true,
	                	numericality: true

 	validates :status, presence: true
	         validates_inclusion_of :status, in: Account.statuses.keys

 	validates :person_type, presence: true
 	validates :person_id, presence: true

 	belongs_to :person, polymorphic: true
end
