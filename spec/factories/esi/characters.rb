FactoryBot.define do
  factory :esi_character, class: "Evematic::ESI::Character" do
    id { Faker::Number.between(from: 90_000_000, to: 98_000_000) }
    birthday { Faker::Date.between(from: 10.years.ago, to: Time.zone.today) }
    corporation_id { Faker::Number.between(from: 98_000_000, to: 99_000_000) }
    esi_etag { SecureRandom.hex(28) }
    esi_expires_at { 1.hour.from_now }
    esi_last_modified_at { Time.zone.now }
    gender { Faker::Gender.binary_type.downcase }
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    bloodline_id { [5, 10, 25, 1, 6, 11, 26, 2, 7, 12, 27, 3, 8, 13, 4, 9, 14, 19].sample }
    race_id { [1, 2, 4, 8].sample }

    trait :with_alliance do
      association :alliance, factory: :esi_alliance
    end
  end
end
