FactoryBot.define do
  factory :esi_alliance, class: "Evematic::ESI::Alliance" do
    id { Faker::Number.between(from: 99_000_000, to: 100_000_000) }
    date_founded { Faker::Date.between(from: 10.years.ago, to: Time.zone.today) }
    esi_etag { SecureRandom.hex(28) }
    esi_expires_at { 1.hour.from_now }
    esi_last_modified_at { Time.zone.now }
    name { Faker::Company.name }
    ticker { Faker::Finance.ticker }
    creator_corporation_id { Faker::Number.between(from: 98_000_000, to: 99_000_000) }
    creator_id { Faker::Number.between(from: 90_000_000, to: 98_000_000) }
  end
end
