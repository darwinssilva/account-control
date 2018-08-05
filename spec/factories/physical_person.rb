FactoryGirl.define do
  factory :physical_person do
    cpf { Faker::Number.number(11) }
    name { Faker::Name.name }
    birthdate { Date.today }

     trait :invalid do
      cpf { Faker::Number.number(5) }
      name { '' }
      birthdate { (Date.today) }
    end
  end
end 