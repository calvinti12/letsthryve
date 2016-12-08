class CreateGoalEncouragements < ActiveRecord::Migration[5.0]
  def change
    create_table :goal_encouragements do |t|
      t.integer :goal_id
      t.integer :user_id
      t.string :text

      t.timestamps
    end
  end
end
