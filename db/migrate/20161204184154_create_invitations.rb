class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :user_id
      t.string :what
      t.string :details
      t.string :where
      t.string :when
      t.datetime :created_at

      t.timestamps
    end
  end
end
