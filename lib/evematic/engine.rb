Gem.loaded_specs["evematic"].dependencies.each do |dep|
  require dep.name
end

class Evematic::Engine < ::Rails::Engine
  isolate_namespace Evematic

  config.app_middleware.use(
    Rack::Static,
    urls: ["evematic-assets"],
    root: Evematic::Engine.root.join("public")
  )

  initializer "evematic.inflections" do
    ActiveSupport::Inflector.inflections(:en) do |inflect|
      inflect.acronym "API"
      inflect.acronym "ESI"
      inflect.acronym "EVE"
      inflect.acronym "OAuth"
      inflect.acronym "OmniAuth"
      inflect.acronym "SSO"
      inflect.acronym "UI"
    end
  end
end
