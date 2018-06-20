FactoryBot.define do
  factory :organization do
    name   { Faker::Company.name }
    line1   { Faker::Address.street_address }
    city    { Faker::Address.city }
    state   { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip_code }
    phone   { Faker::PhoneNumber.phone_number }
  end
end
