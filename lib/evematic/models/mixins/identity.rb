module Evematic::Models::Mixins::Identity
  extend ActiveSupport::Concern

  included do
    self.table_name = Evematic.config.identities_table

    belongs_to :account, class_name: account_class
    belongs_to :character, class_name: esi_character_class

    has_one :alliance,
      class_name: esi_alliance_class,
      through: :character
    has_one :corporation,
      class_name: esi_corporation_class,
      through: :character

    delegate :name, to: :character
  end

  module ClassMethods
    def sso_authenticate_by(character)
      character.sync
      character.alliance.sync if character.alliance.present?
      character.corporation.sync

      return unless access_rule_model.allows?(character)

      identity = identity_model.find_by(character:)
      return identity if identity.present?

      identity = identity_model.new(character:, main: true)
      identity.build_account
      identity.save!
      identity
    end
  end
end
