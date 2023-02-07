module Evematic::Models::Mixins::ESI::Character
  extend ActiveSupport::Concern

  included do
    include Evematic::Models::Mixins::ESI::Entity

    self.table_name = Evematic.config.esi_characters_table

    belongs_to :alliance, class_name: esi_alliance_class, optional: true
    belongs_to :corporation, class_name: esi_corporation_class

    has_one :access_rule,
      as: :principal,
      dependent: :restrict_with_exception

    has_one :identity,
      class_name: identity_class,
      dependent: :restrict_with_exception

    has_one :account,
      class_name: account_class,
      through: :identity

    before_validation :ensure_alliance
    before_validation :ensure_corporation
  end

  private

  def fetch_esi_attributes
    esi_get("/latest/characters/#{id}/")
  end

  def ensure_alliance
    self.alliance = esi_alliance_model.find_or_create_by(id: alliance_id) if alliance_id.present?
  end

  def ensure_corporation
    self.corporation = esi_corporation_model.find_or_create_by(id: corporation_id)
  end
end
