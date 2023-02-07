module Evematic::Models::Mixins::AccessRule
  extend ActiveSupport::Concern

  included do
    self.table_name = Evematic.config.access_rules_table

    belongs_to :principal, polymorphic: true

    validates :action, inclusion: {in: ["allow", "deny"]}
    validates :principal_type,
      inclusion: {
        in: [
          esi_alliance_class,
          esi_character_class,
          esi_corporation_class
        ]
      }

    scope :allowed, -> { where(action: "allow") }
    scope :denied, -> { where(action: "deny") }
  end

  module ClassMethods
    def allows?(character)
      return false if denied.exists? { |rule| rule.matches?(character) }

      return true if allowed.exists? { |rule| rule.matches?(character) }

      false
    end
  end

  def matches?(character)
    case principal_type
    when esi_character_class
      principal_id == character.id
    when esi_corporation_class
      principal_id == character.corporation_id
    when esi_alliance_class
      principal_id == character.alliance_id
    end
  end
end
