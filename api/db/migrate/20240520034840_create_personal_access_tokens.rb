class CreatePersonalAccessTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :personal_access_tokens do |t|
      t.string :user_id
      t.string :token
      t.timestamp :last_used_at,null: true
      t.timestamp :expires_at,null: true

      t.timestamps null: true
    end
  end
end
