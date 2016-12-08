class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :activities
  has_many :goals
  has_many :invitations
  has_many :invitation_responses
end

# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  fb_messenger_id   :string
#  fb_profile_id     :string
#  first_name        :string
#  full_name         :string
#  picture_url       :string
#  ignore            :boolean          default(FALSE)
#  last_message_sent :string
#  interests         :string
#  availability      :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_fb_messenger_id  (fb_messenger_id)
#  index_users_on_fb_profile_id    (fb_profile_id)
#
