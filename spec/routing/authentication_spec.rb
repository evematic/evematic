require "rails_helper"

RSpec.describe "Authentication" do
  specify { expect(get("/auth/eve/callback")).to route_to("evematic/sso_callbacks#eve") }
  specify { expect(get("/login")).to route_to("evematic/sessions#new") }
  specify { expect(delete("/logout")).to route_to("evematic/sessions#destroy") }
end
