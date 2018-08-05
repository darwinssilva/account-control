FactoryGirl.define do
  factory :transaction do
    transactional_code "MyString"
    type 1
    value "9.99"
    belongs_to ""
    origin_account_before_transaction "9.99"
    belongs_to ""
    destination_account_before_transaction "9.99"
    reversed false
    reversed_transactional_code "MyString"
  end
end
