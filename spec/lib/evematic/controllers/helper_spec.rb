require "rails_helper"

RSpec.describe Evematic::Controllers::Helper, type: :controller do
  controller(Evematic::ApplicationController) do
    def does_not_exist
      not_found
    end
  end

  before do
    routes.draw do
      get "/does_not_exist" => "evematic/application#does_not_exist"
    end
  end

  specify "#not_found raises a routing error" do
    expect { get :does_not_exist }.to raise_error(ActionController::RoutingError)
  end
end
