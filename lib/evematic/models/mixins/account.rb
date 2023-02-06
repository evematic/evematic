module Evematic::Models::Mixins::Account
  extend ActiveSupport::Concern

  included do
    self.table_name = Evematic.config.accounts_table

    has_one :main_identity,
      -> { where(main: true) },
      class_name: identity_class

    has_one :main_character,
      class_name: esi_character_class,
      through: :main_identity,
      source: :character
    has_one :main_alliance,
      class_name: esi_alliance_class,
      through: :main_character,
      source: :alliance
    has_one :main_corporation,
      class_name: esi_corporation_class,
      through: :main_character,
      source: :corporation

    has_many :identities, dependent: :destroy

    has_many :characters,
      class_name: esi_character_class,
      through: :identities
    has_many :alliances,
      class_name: esi_alliance_class,
      through: :characters
    has_many :corporations,
      class_name: esi_corporation_class,
      through: :characters

    delegate :name, to: :main_character
  end
end
