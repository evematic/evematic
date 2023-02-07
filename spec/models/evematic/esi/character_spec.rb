require "rails_helper"

RSpec.describe Evematic::ESI::Character do
  subject(:character) { described_class.find_or_create_by!(id:) }

  let(:id) { 2113024536 }

  it "creates from ESI", :vcr do
    expect(character).to be_persisted
  end
end
