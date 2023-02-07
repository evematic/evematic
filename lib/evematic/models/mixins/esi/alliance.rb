module Evematic::Models::Mixins::ESI::Alliance
  extend ActiveSupport::Concern

  included do
    include Evematic::Models::Mixins::ESI::Entity

    self.table_name = Evematic.config.esi_alliances_table

    has_one :access_rule,
      as: :principal,
      dependent: :restrict_with_exception

    has_many :corporations,
      class_name: esi_corporation_class,
      dependent: :restrict_with_exception
    has_many :characters,
      class_name: esi_character_class,
      dependent: :restrict_with_exception

    has_many :identities,
      class_name: identity_class,
      through: :characters

    has_many :accounts,
      class_name: account_class,
      through: :identities
  end

  private

  def fetch_esi_attributes
    esi_get("/latest/alliances/#{id}/")
  end
end
