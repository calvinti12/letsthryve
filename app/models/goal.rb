class Goal < ApplicationRecord
  
	GOAL_STATES = ['Failed', 'Tried', 'Complete', 'Not Complete']

	# Relationships
	belongs_to :user

	# Scopes
	scope :for_user, -> (user) { where(user: user) }
	scope :by_complete, -> { order('state DESC') }
	scope :chronological, -> { order('created_at DESC') }

	# Methods
  
end

# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  text       :string
#  state      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
