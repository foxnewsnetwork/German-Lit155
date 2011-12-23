class AddSocialNetworkToPerson < ActiveRecord::Migration
  def self.up
  	add_column :people, :facebook, :string
  	add_column :people, :linkedin, :string
  	add_column :people, :twitter, :string
  	add_column :people, :tumblr, :string
  	add_column :people, :wikipedia, :string
  	
  	add_index :people, :facebook
  	add_index :people, :linkedin
  	add_index :people, :twitter
  	add_index :people, :tumblr
  	add_index :people, :wikipedia
  end

  def self.down
	remove_index :people, :facebook
  	remove_index :people, :linkedin
  	remove_index :people, :twitter
  	remove_index :people, :tumblr
  	remove_index :people, :wikipedia
  	
  	remove_column :people, :facebook
  	remove_column :people, :linkedin
  	remove_column :people, :twitter
  	remove_column :people, :tumblr
  	remove_column :people, :wikipedia
  end
end
