require "rails_helper"

RSpec.describe Evematic::ESI::Corporation do
  subject(:corporation) { described_class.find_or_create_by!(id:) }

  let(:id) { 98613799 }

  it "creates from ESI", :vcr do
    expect(corporation).to be_persisted
  end
end
