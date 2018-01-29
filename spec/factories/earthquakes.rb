FactoryBot.define do
  factory :earthquake do
    address   { Faker::Address.street_address }
    latitude  { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    magnitude { Faker::Number.decimal(1, 2) }
    time      { Faker::Time.between(DateTime.now - 10, DateTime.now) }
    tsunami   { Faker::Number.between(0, 1) }
  end
end
