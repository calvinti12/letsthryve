class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.string :picture_url_override
      t.string :text
      t.string :time
      t.string :location

      t.timestamps
    end
  end
end
