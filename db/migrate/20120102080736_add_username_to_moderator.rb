class AddUsernameToModerator < ActiveRecord::Migration
  def self.up
  	add_column :moderators, :username, :string
  	add_index :moderators, :username
  end

  def self.down
	remove_index :moderators, :username
  	remove_column :moderators, :username
  end
end
