class InvitationResponse < ApplicationRecord

  belongs_to :invitation
  belongs_to :user

  scope :alphabetical, ->{ joins(:users).order('user.full_name') }

end

# == Schema Information
#
# Table name: invitation_responses
#
#  id            :integer          not null, primary key
#  invitation_id :integer
#  user_id       :integer
#  response      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
