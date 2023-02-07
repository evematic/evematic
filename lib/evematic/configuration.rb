module Evematic
  module Configuration
    require "evematic/configuration/builder"
  end

  class << self
    def configuration_builder
      @configuration_builder ||= Evematic::Configuration::Builder.new
    end

    def configuration
      configuration_builder
    end
    alias_method :config, :configuration

    def configure(&block)
      configuration_builder.configure(&block)
    end
  end
end
