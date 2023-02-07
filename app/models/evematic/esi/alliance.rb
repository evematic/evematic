# == Schema Information
#
# Table name: esi_alliances
#
#  id                      :integer          not null, primary key
#  date_founded            :date             not null
#  esi_etag                :string
#  esi_expires_at          :datetime
#  esi_last_modified_at    :datetime
#  name                    :string           not null
#  ticker                  :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  creator_corporation_id  :integer          not null
#  creator_id              :integer          not null
#  executor_corporation_id :integer
#  faction_id              :integer
#
# Indexes
#
#  index_esi_alliances_on_ticker  (ticker) UNIQUE
#
class Evematic::ESI::Alliance < Evematic::ApplicationRecord
  include Evematic::Models::Mixins::ESI::Alliance
end
