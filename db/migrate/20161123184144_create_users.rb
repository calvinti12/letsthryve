class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fb_messenger_id
      t.string :fb_profile_id
      t.string :first_name
      t.string :full_name
      t.string :picture_url
      t.boolean :ignore, default: false
      t.string :last_message_sent
      t.string :interests
      t.string :availability
      t.timestamps
    end

    add_index :users, :fb_messenger_id
    add_index :users, :fb_profile_id
  end
end
