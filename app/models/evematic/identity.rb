# == Schema Information
#
# Table name: identities
#
#  id           :integer          not null, primary key
#  main         :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :integer          not null
#  character_id :integer          not null
#
# Indexes
#
#  index_identities_on_account_id_and_character_id  (account_id,character_id) UNIQUE
#  index_identities_on_account_id_and_main          (account_id,main) UNIQUE
#
# Foreign Keys
#
#  account_id    (account_id => accounts.id)
#  character_id  (character_id => esi_characters.id)
#
class Evematic::Identity < Evematic::ApplicationRecord
  include Evematic::Models::Mixins::Identity
end
