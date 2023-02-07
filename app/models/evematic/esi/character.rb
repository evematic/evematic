# == Schema Information
#
# Table name: esi_characters
#
#  id                   :integer          not null, primary key
#  birthday             :date             not null
#  description          :text
#  esi_etag             :string
#  esi_expires_at       :datetime
#  esi_last_modified_at :datetime
#  gender               :string           not null
#  name                 :string           not null
#  security_status      :decimal(, )
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  alliance_id          :integer
#  bloodline_id         :integer          not null
#  corporation_id       :integer          not null
#  faction_id           :integer
#  race_id              :integer          not null
#
# Indexes
#
#  index_esi_characters_on_alliance_id     (alliance_id)
#  index_esi_characters_on_corporation_id  (corporation_id)
#
# Foreign Keys
#
#  alliance_id     (alliance_id => esi_alliances.id)
#  corporation_id  (corporation_id => esi_corporations.id)
#
class Evematic::ESI::Character < Evematic::ApplicationRecord
  include Evematic::Models::Mixins::ESI::Character
end
