RSpec.shared_context "with authorized account" do
  let(:current_account) { create(:account) }
  let(:current_character) { create(:esi_character, id: 2113024536) }
  let(:current_identity) { create(:identity, character: current_character, account: current_account, main: true) }
end

RSpec.shared_context "with logged in account" do
  include_context "with authorized account"

  before { log_in(current_identity) }
end

RSpec.shared_context "with authorized admin" do
  let(:current_account) { create(:account, admin: true) }
  let(:current_character) { create(:esi_character, id: 2113024536) }
  let(:current_identity) { create(:identity, character: current_character, account: current_account, main: true) }
end

RSpec.shared_context "with logged in admin" do
  include_context "with authorized admin"

  before { log_in(current_identity) }
end
