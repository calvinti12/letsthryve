class Activity < ApplicationRecord
  # Relationships
  belongs_to :user

  # Scopes
  scope :for_user, ->(user){ where(user: user) }
  scope :for_user_friends, ->(user){ where(user: user.friends) }
  scope :except_user, ->(user){ where('user_id != ?', user.id) }
  scope :chronological, ->{ order('created_at DESC') }

  # Methods

end

# == Schema Information
#
# Table name: activities
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  picture_url_override :string
#  text                 :string
#  time                 :string
#  location             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
