require "rails_helper"

RSpec.describe Evematic do
  it "has a version" do
    expect(described_class::VERSION).to match(/\d+\.\d+\.\d+/)
  end
end
