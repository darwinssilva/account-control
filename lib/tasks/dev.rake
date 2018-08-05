namespace :dev do
  desc "Create physical people"
  task setup: :environment do
  	p 'Create physical people'
  	10.times do |i|
  		PhysicalPerson.create(
  			cpf: Faker::Number.number(11),
  			name: Faker::Name.name,
  			birthdate: Faker::Date.between(2.days.ago, Date.today)
  		)
  	end
  	p 'Ok'

    p 'Create legal people'
    10.times do |i|
      LegalPerson.create(
        cnpj: Faker::Number.number(14),
        company_name: Faker::Company.name,
        fantasy_name: Faker::Company.name
      )
    end
    p 'Ok'

    p 'Create legal accounts'
    5.times do |i|
      Account.create(
        name: Faker::Name.name,
        balance: Faker::Number.number(6),
        status: (0..2).to_a.sample,
        person_type: 'LegalPerson',
        person_id: LegalPerson.all.sample.id
      )
    end
    p 'Ok'

    p 'Create physical accounts'
    5.times do |i|
      Account.create(
        name: Faker::Name.name,
        balance: Faker::Number.number(6),
        status: (0..2).to_a.sample,
        person_type: 'PhysicalPerson',
        person_id: PhysicalPerson.all.sample.id
      )
    end
    p 'Ok'
  end
end