# == Schema Information
#
# Table name: access_rules
#
#  id             :integer          not null, primary key
#  action         :string           default("deny"), not null
#  principal_type :string           not null
#  created_at     :datetime         not null
#  principal_id   :integer          not null
#
# Indexes
#
#  index_access_rules_on_principal  (principal_type,principal_id) UNIQUE
#
class Evematic::AccessRule < Evematic::ApplicationRecord
  include Evematic::Models::Mixins::AccessRule
end
