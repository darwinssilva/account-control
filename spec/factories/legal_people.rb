FactoryGirl.define do

  factory :legal_person do
    cnpj { Faker::Number.number(14) }
    company_name { Faker::Company.name }
    fantasy_name { Faker::Company.name }

     trait :invalida do
      cnpj { Faker::Number.number(5) }
      company_name { '' }
      fantasy_name { '' }
    end
  end
end