module Evematic::Models::Mixins::ESI::Corporation
  extend ActiveSupport::Concern

  included do
    include Evematic::Models::Mixins::ESI::Entity

    self.table_name = Evematic.config.esi_corporations_table

    belongs_to :alliance,
      class_name: esi_alliance_class,
      optional: true

    has_one :access_rule,
      as: :principal,
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

    before_validation :ensure_alliance
  end

  private

  def fetch_esi_attributes
    esi_get("/latest/corporations/#{id}/")
  end

  def ensure_alliance
    self.alliance = esi_alliance_model.find_or_create_by(id: alliance_id) if alliance_id.present?
  end
end
