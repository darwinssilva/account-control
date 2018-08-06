FactoryGirl.define do
  factory :transaction do
    transactional_code "TestCode"
    type 1
    value "100.0"
    origin_account_id 1
    origin_account_before_transaction "100.0"
    destination_account_id 1
    destination_account_before_transaction "100.0"
    reversed false
    reversed_transactional_code ""
  end
end