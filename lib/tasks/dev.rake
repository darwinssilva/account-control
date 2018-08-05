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
  end
end