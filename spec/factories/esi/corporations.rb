FactoryBot.define do
  factory :esi_corporation, class: "Evematic::ESI::Corporation" do
    id { Faker::Number.between(from: 98_000_000, to: 99_000_000) }
    date_founded { Faker::Date.between(from: 10.years.ago, to: Time.zone.today) }
    esi_etag { SecureRandom.hex(28) }
    esi_expires_at { 1.hour.from_now }
    esi_last_modified_at { Time.zone.now }
    member_count { Faker::Number.between(from: 1, to: 12_601) }
    name { Faker::Company.name }
    tax_rate { Faker::Number.between(from: 0.0, to: 1.0) }
    ticker { Faker::Finance.ticker }
    ceo_id { Faker::Number.between(from: 90_000_000, to: 98_000_000) }

    trait :with_alliance do
      association :alliance, factory: :esi_alliance
    end
  end
end
