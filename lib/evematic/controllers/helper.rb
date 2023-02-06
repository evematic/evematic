module Evematic::Controllers::Helper
  extend ActiveSupport::Concern

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end
end
