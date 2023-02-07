class Evematic::Routes::Routers::Authentication < Evematic::Routes::Router
  option :controllers, default: -> { {sessions: "evematic/sessions", sso_callbacks: "evematic/sso_callbacks"} }
  option :path_names, default: -> { {login: "login", logout: "logout", callback: "auth/eve/callback"} }

  def draw!
    return unless Evematic.config.authentication_enabled

    routes.scope(scope) do
      routes.get(path_names[:callback], to: "#{controllers[:sso_callbacks]}#eve", as: :sso_callback)
      routes.get(path_names[:login], to: "#{controllers[:sessions]}#new")
      routes.delete(path_names[:logout], to: "#{controllers[:sessions]}#destroy")
    end
  end
end
