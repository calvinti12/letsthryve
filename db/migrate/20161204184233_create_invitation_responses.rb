class CreateInvitationResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :invitation_responses do |t|
      t.integer :invitation_id
      t.integer :user_id
      t.string :response

      t.timestamps
    end
  end
end
