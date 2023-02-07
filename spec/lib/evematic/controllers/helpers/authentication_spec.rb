require "rails_helper"

RSpec.describe Evematic::Controllers::Helpers::Authentication, :vcr, type: :controller do
  controller(Evematic::ApplicationController) do
    before_action :require_admin!, only: [:admin]
    before_action :require_login!, only: [:admin, :authenticated]

    def admin
      head :ok
    end

    def authenticated
      head :ok
    end
  end

  before do
    routes.draw do
      get "/admin" => "evematic/application#admin"
      get "/authenticated" => "evematic/application#authenticated"
    end
  end

  describe "#logged_in?" do
    context "when logged in" do
      include_context "with logged in account"

      it "returns true" do
        expect(controller).to be_logged_in
      end
    end

    context "when logged out" do
      it "returns false" do
        expect(controller).not_to be_logged_in
      end
    end
  end

  describe "#require_admin!" do
    before { log_in(current_identity) }

    context "when logged in as admin" do
      include_context "with authorized admin"

      it "returns success" do
        get :admin
        expect(response).to have_http_status(:success)
      end
    end

    context "when logged in as non-admin" do
      include_context "with authorized account"

      it "raises not found" do
        expect { get :admin }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "#require_login!" do
    include_context "with authorized account"

    specify "when logged in it returns success" do
      log_in(current_identity)
      get :authenticated

      expect(response).to have_http_status(:success)
    end

    specify "when logged out it redirects to the login page" do
      get :authenticated
      expect(response).to redirect_to(login_path)
    end
  end

  describe "#store_location" do
    shared_examples "stores path" do |path, expected|
      let(:path) { path }

      it "normalizes the path" do
        controller.store_location(path)
        expect(controller.stored_location).to eq(expected)
      end
    end

    include_examples "stores path", "/foo.bar", "/foo.bar"
    include_examples "stores path", "//host/foo.bar", "/foo.bar"
    include_examples "stores path", "///foo.bar", "/foo.bar"
    include_examples "stores path", "/foo.bar\">Carry", nil
    include_examples "stores path", "/foo?bar=baz", "/foo?bar=baz"
    include_examples "stores path", "/foo#bar", "/foo#bar"
  end

  describe "#stored_location" do
    it "returns the location" do
      session["return_to"] = "/foo.bar"
      expect(controller.stored_location).to eq("/foo.bar")
    end

    it "cleans information after reading" do
      session["return_to"] = "/foo.bar"
      controller.stored_location
      expect(session["return_to"]).to be_nil
    end
  end
end
