class InvitationResponse < ApplicationRecord
  RESPONSES = ['seen', 'accepted', 'declined']

  belongs_to :invitation
  belongs_to :user

  scope :alphabetical, ->{ joins(:user).order('users.full_name') }

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
