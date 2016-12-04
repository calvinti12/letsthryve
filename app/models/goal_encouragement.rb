class GoalEncouragement < ApplicationRecord
	# Relationships
	belongs_to :goal
	belongs_to :user
  
  # Scopes
	scope :chronological, -> { order('created_at DESC') }

	# Methods

end

# == Schema Information
#
# Table name: goal_encouragements
#
#  id         :integer          not null, primary key
#  goal_id    :integer
#  user_id    :integer
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
