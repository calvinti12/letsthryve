class Goal < ApplicationRecord
  
	GOAL_STATES = ['Failed', 'Tried', 'Complete', 'Not Complete']
  GOAL_ACTIONS = ['didn\'t achieve their goal', 'tried to achieve their goal', 'achieved their goal!']

	# Relationships
	belongs_to :user
	has_many :goal_encouragements

	# Scopes
	scope :for_user, -> (user) { where(user: user) }
	scope :by_state, -> { order('state DESC') }
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
