# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  admin      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Evematic::Account < Evematic::ApplicationRecord
  include Evematic::Models::Mixins::Account
end
