FactoryGirl.define do

  factory :account do
    name { Faker::Name.name }
    balance { Faker::Number.number(6) }
    status { (0..2).to_a.sample }
    ancestry { nil }

     trait :physical_person do
      person_type { 'PhysicalPerson' }
      person_id { FactoryGirl.create(:physical_person).id }
    end

     trait :legal_person do
      person_type { 'LegalPerson' }
      person_id { FactoryGirl.create(:legal_person).id }
    end
  end
end