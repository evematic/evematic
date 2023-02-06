require "rails_helper"

RSpec.describe Evematic::AccessRule do
  subject(:allowed) { described_class.allows?(character) }

  let(:character) { Evematic::ESI::Character.find_or_create_by(id: 2113024536) }
  let(:alliance) { character.alliance }
  let(:corporation) { character.corporation }

  describe ".allows?", :vcr do
    it "returns true when character is allowed" do
      described_class.create!(principal: character, action: "allow")

      expect(allowed).to be_truthy
    end

    it "returns false when no rules match" do
      expect(allowed).to be_falsey
    end

    it "returns false when character is denied" do
      described_class.create!(principal: character, action: "deny")
      described_class.create!(principal: corporation, action: "allow")

      expect(allowed).to be_falsey
    end

    it "returns false when corporation is denied" do
      described_class.create!(principal: character, action: "allow")
      described_class.create!(principal: corporation, action: "deny")

      expect(allowed).to be_falsey
    end

    it "returns false when alliance is denied" do
      described_class.create!(principal: character, action: "allow")
      described_class.create!(principal: alliance, action: "deny")

      expect(allowed).to be_falsey
    end
  end

  describe "#matches?", :vcr do
    it "returns true when principal matches character" do
      access_rule = create(:access_rule, principal: character)
      expect(access_rule).to be_matches(character)
    end

    it "returns true when principal corporation matches character corporation" do
      access_rule = create(:access_rule, principal: corporation)
      expect(access_rule).to be_matches(character)
    end

    it "returns true when principal alliance matches character alliance" do
      access_rule = create(:access_rule, principal: alliance)
      expect(access_rule).to be_matches(character)
    end
  end
end
