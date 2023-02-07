module Evematic::Routes::Helper
  def evematic_authentication(**opts)
    Evematic::Routes::Routers::Authentication.new(self, **opts).draw!
  end
end
