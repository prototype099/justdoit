class CreateOauthTokens < ActiveRecord::Migration
  def change
    create_table :oauth_tokens do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :access_token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
