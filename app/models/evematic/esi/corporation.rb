# == Schema Information
#
# Table name: esi_corporations
#
#  id                   :integer          not null, primary key
#  date_founded         :date             not null
#  description          :text
#  esi_etag             :string
#  esi_expires_at       :datetime
#  esi_last_modified_at :datetime
#  member_count         :integer          not null
#  name                 :string           not null
#  shares               :bigint
#  tax_rate             :decimal(, )      not null
#  ticker               :string           not null
#  url                  :string
#  war_eligible         :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  alliance_id          :integer
#  ceo_id               :integer          not null
#  creator_id           :integer          not null
#  faction_id           :integer
#  home_station_id      :integer
#
# Indexes
#
#  index_esi_corporations_on_alliance_id  (alliance_id)
#  index_esi_corporations_on_ticker       (ticker) UNIQUE
#
# Foreign Keys
#
#  alliance_id  (alliance_id => esi_alliances.id)
#
class Evematic::ESI::Corporation < Evematic::ApplicationRecord
  include Evematic::Models::Mixins::ESI::Corporation
end
