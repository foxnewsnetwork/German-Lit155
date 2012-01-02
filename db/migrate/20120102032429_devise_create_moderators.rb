class DeviseCreateModerators < ActiveRecord::Migration
  def self.up
    create_table(:moderators) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.timestamps
    end

    add_index :moderators, :email,                :unique => true
    add_index :moderators, :reset_password_token, :unique => true
    # add_index :moderators, :confirmation_token,   :unique => true
    # add_index :moderators, :unlock_token,         :unique => true
    # add_index :moderators, :authentication_token, :unique => true
  end

  def self.down
    drop_table :moderators
  end
end
