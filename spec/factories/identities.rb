FactoryBot.define do
  factory :identity, class: "Evematic::Identity" do
    association :character, factory: :esi_character
  end
end
