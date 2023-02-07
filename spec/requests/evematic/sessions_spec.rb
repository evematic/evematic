require "rails_helper"

RSpec.describe "Sessions", vcr: true do
  describe "GET /login" do
    context "when logged out" do
      before { get "/login" }

      it "returns success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when logged in" do
      include_context "with authorized account"

      before do
        log_in(current_identity)
        get "/login"
      end

      it "redirects to the after login path" do
        expect(response).to redirect_to("/")
      end
    end
  end

  describe "GET /logout" do
    context "when logged out" do
      before { delete "/logout" }

      it "redirects to the after logout path" do
        expect(response).to redirect_to("/")
      end
    end

    context "when logged in" do
      include_context "with authorized account"

      before do
        log_in(current_identity)
        delete "/logout"
      end

      it "redirects to the after logout path" do
        expect(response).to redirect_to("/")
      end
    end
  end
end
