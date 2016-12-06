class Invitation < ApplicationRecord
  # Relationships
  belongs_to :user
  has_many :invitation_responses

  # Scopes
  scope :chronological, ->{ order('created_at DESC') }
end

# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  what       :string
#  details    :string
#  where      :string
#  when       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
