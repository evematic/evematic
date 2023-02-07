require "rails_helper"

RSpec.describe Evematic::Identity do
  let(:character_id) { 2113024536 }
  let(:character) { Evematic::ESI::Character.find_or_create_by!(id: character_id) }

  it "returns an identity when access rule allows character", :vcr do
    allow(Evematic::AccessRule).to receive(:allows?).with(character).and_return(true)

    expect(described_class.sso_authenticate_by(character)).to be_a(described_class)
  end

  it "returns nil when access rule denies character", :vcr do
    allow(Evematic::AccessRule).to receive(:allows?).with(character).and_return(false)

    expect(described_class.sso_authenticate_by(character)).to be_nil
  end

  context "when identity exists", :vcr do
    let!(:account) { create(:account) }
    let!(:identity) { account.identities.create!(character: character) }

    before do
      allow(Evematic::AccessRule).to receive(:allows?).with(character).and_return(true)
    end

    it "does not create a new account" do
      expect { described_class.sso_authenticate_by(character) }.not_to(
        change(Evematic::Account, :count)
      )
    end

    it "returns the identity" do
      expect(described_class.sso_authenticate_by(character)).to eq(identity)
    end
  end

  context "when identity does not exist", :vcr do
    before do
      allow(Evematic::AccessRule).to receive(:allows?).with(character).and_return(true)
    end

    it "creates a new account" do
      expect { described_class.sso_authenticate_by(character) }.to(
        change(Evematic::Account, :count)
      )
    end

    it "persists the identity" do
      expect(described_class.sso_authenticate_by(character)).to be_persisted
    end

    it "returns the identity" do
      expect(described_class.sso_authenticate_by(character).character).to eq(character)
    end
  end
end
