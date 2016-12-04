class Activity < ApplicationRecord
  # Relationships
  belongs_to :user

  # Scopes
  scope :for_user, ->(user){ where(user: user) }
  scope :for_user_friends, ->(user){ where(user: user.friends) }
  scope :chronological, ->{ order('created_at DESC') }

  # Methods

end
