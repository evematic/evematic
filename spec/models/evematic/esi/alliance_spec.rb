require "rails_helper"

RSpec.describe Evematic::ESI::Alliance do
  subject(:alliance) { described_class.find_or_create_by!(id:) }

  let(:id) { 99010079 }

  it "creates from ESI", :vcr do
    expect(alliance).to be_persisted
  end
end
