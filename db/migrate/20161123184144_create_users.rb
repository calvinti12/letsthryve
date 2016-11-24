class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :fb_messenger_id
      t.string :fb_profile_id
      t.boolean :ignore, default: false
      t.string :last_message_sent
      t.timestamps
    end

    add_index :users, :fb_messenger_id, name: 'fb_messenger_id_idx'
    add_index :users, :fb_profile_id, name: 'fb_profile_id_idx'
  end
end
