class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :text
      t.integer :state

      t.timestamps
    end
  end
end
