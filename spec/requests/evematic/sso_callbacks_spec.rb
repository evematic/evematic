require "rails_helper"

RSpec.describe "SSOCallbacks" do
  let(:character_id) { 2113024536 }

  before do
    OmniAuth.config.mock_auth[:eve] = OmniAuth::AuthHash.new(
      {provider: :eve, uid: character_id}
    )
  end

  describe "GET /auth/eve/callback", :vcr do
    context "when character is allowed access" do
      before do
        allow(Evematic::AccessRule).to receive(:allows?).and_return(true)
        post("/auth/eve")
        follow_redirect! # /auth/eve/callback
      end

      it "redirects to the after login path" do
        expect(response).to redirect_to("/")
      end
    end

    context "when character is denied access" do
      before do
        allow(Evematic::AccessRule).to receive(:allows?).and_return(false)
        post("/auth/eve")
        follow_redirect! # /auth/eve/callback
      end

      it "redirects to the login page" do
        expect(response).to redirect_to("/login")
      end
    end
  end
end
