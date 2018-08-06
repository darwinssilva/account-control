FactoryGirl.define do
  factory :load_transaction, class: Transaction do
    transaction_type { 'charge' }
    value { '500' }
    origin_account_id { nil }
    origin_account_before_transaction { nil }
    destination_account_id { nil }
    destination_account_before_transaction { nil }

    trait :invalid do
      transaction_type { '' }
      value { '' }
      origin_account_id { nil }
      origin_account_before_transaction { nil }
      destination_account_id { nil }
      destination_account_before_transaction { nil }
    end
  end
end