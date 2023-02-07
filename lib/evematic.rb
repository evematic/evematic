require "evematic/version"
require "evematic/configuration"
require "evematic/engine"

module Evematic
  def self.setup
    configuration_builder.clear_cache!

    if defined?(Config)
      settings = Config.const_name.safe_constantize

      configure do |config|
        config.esi_client_id = settings.esi.client_id
        config.esi_client_secret = settings.esi.client_secret
      end
    end
  end

  module ESI
  end

  module Models
    module ESI
    end
  end
end

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  "api" => "API",
  "eve" => "EVE",
  "esi" => "ESI",
  "oauth" => "OAuth",
  "omniauth" => "OmniAuth",
  "sso" => "SSO"
)
loader.ignore("#{__dir__}/generators")
loader.enable_reloading
loader.setup
loader.eager_load
