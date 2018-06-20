FactoryBot.define do
  factory :dog do
    name   { Faker::Dog.name }
    breed  { Faker::Dog.breed }
    sex    { Faker::Dog.gender }
    weight { Faker::Number.between(1, 150) }
    dob    { Faker::Date.birthday(0, 16) }
  end
end
