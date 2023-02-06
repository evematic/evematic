require "rails"
require "omniauth"
require "omniauth/strategies/eve_online"
require "omniauth/rails_csrf_protection"
require "turbo-rails"

require "evematic/configuration"
require "evematic/esi"
require "evematic/models"

OmniAuth::Strategies::EVEOnline.class_eval do
  # Hack to allow passing scope as a query parameter to /auth/eve
  def callback_url
    full_host + callback_path
  end
end

class Evematic::Engine < ::Rails::Engine
  config.evematic = Evematic.config

  config.to_prepare do
    Evematic.setup
  end

  initializer "evematic.assets" do
    config.middleware.use(
      Rack::Static,
      urls: ["evematic"],
      root: Evematic::Engine.root.join("public")
    )
  end

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

  initializer "evematic.routes" do
    ActionDispatch::Routing::Mapper.include Evematic::Routes::Helper
  end

  initializer "evematic.action_controller" do
    ActiveSupport.on_load(:action_controller) do
      include Evematic::Models::Helper
      include Evematic::Controllers::Helper
      include Evematic::Controllers::Helpers::Authentication if Evematic.config.authentication_enabled
    end
  end

  initializer "evematic.action_view" do
    ActiveSupport.on_load(:action_view) do
      include Evematic::Models::Helper
      include Evematic::Views::Helper
    end
  end

  initializer "evematic.active_job" do
    ActiveSupport.on_load(:active_job) do
      include Evematic::Models::Helper
      include Evematic::Jobs::Helper
    end
  end

  initializer "evematic.active_record" do
    ActiveSupport.on_load(:active_record) do
      include Evematic::Models::Helper
    end
  end

  initializer "evematic.i18n" do |app|
    app.config.i18n.raise_on_missing_translations = true if Rails.env.local?
  end

  initializer "evematic.omniauth" do |app|
    next unless Evematic.config.authentication_enabled

    OmniAuth.config.logger = Rails.logger

    app.middleware.use OmniAuth::Builder do
      provider OmniAuth::Strategies::EVEOnline,
        name: :eve,
        setup: lambda { |env|
          req = Rack::Request.new(env)
          env["omniauth.strategy"].tap do |strategy|
            strategy.options[:client_id] = Evematic.config.esi_client_id
            strategy.options[:client_secret] = Evematic.config.esi_client_secret
            strategy.options[:scope] = req.params["scope"]
          end
        }
    end
  end
end
