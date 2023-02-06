require "dry-configurable"

class Evematic::Configuration::Builder
  include Dry::Configurable

  delegate_missing_to :config

  setting :authentication_enabled, default: true

  setting :esi_base_url, default: "https://esi.evetech.net"
  setting :esi_client_id, default: -> { ENV.fetch("ESI_CLIENT_ID") }
  setting :esi_client_secret, default: -> { ENV.fetch("ESI_CLIENT_SECRET") }
  setting :esi_detailed_logging, default: false
  setting :esi_retry_options, default: {}
  setting :esi_user_agent, default: "Evematic/1.0 (+https://evematic.dev)"

  setting :esi_alliance_class, default: "Evematic::ESI::Alliance"
  setting :esi_alliances_table, default: "esi_alliances"

  setting :esi_character_class, default: "Evematic::ESI::Character"
  setting :esi_characters_table, default: "esi_characters"

  setting :esi_corporation_class, default: "Evematic::ESI::Corporation"
  setting :esi_corporations_table, default: "esi_corporations"

  setting :access_rule_class, default: "Evematic::AccessRule"
  setting :access_rules_table, default: "access_rules"

  setting :account_class, default: "Evematic::Account"
  setting :accounts_table, default: "accounts"

  setting :identity_class, default: "Evematic::Identity"
  setting :identities_table, default: "identities"

  setting :after_login_path, default: -> { root_path }
  setting :after_logout_path, default: -> { root_path }

  def clear_cache!
    %i[
      access_rule_model
      account_model
      esi_alliance_model
      esi_character_model
      esi_corporation_model
      identity_model
    ].each do |var|
      remove_instance_variable("@#{var}") if instance_variable_defined?("@#{var}")
    end
  end

  def esi_alliance_model
    @esi_alliance_model ||= config.esi_alliance_class.safe_constantize
  end

  def esi_character_model
    @esi_character_model ||= config.esi_character_class.safe_constantize
  end

  def esi_corporation_model
    @esi_corporation_model ||= config.esi_corporation_class.safe_constantize
  end

  def access_rule_model
    @access_rule_model ||= config.access_rule_class.safe_constantize
  end

  def account_model
    @account_model ||= config.account_class.safe_constantize
  end

  def identity_model
    @identity_model ||= config.identity_class.safe_constantize
  end
end
