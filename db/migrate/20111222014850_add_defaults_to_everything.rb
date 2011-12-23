class AddDefaultsToEverything < ActiveRecord::Migration
  def self.up
	remove_index :people, :facebook
	remove_index :people, :linkedin
	remove_index :people, :name
	remove_index :people, :tumblr 
	remove_index :people, :twitter 
	remove_index :people, :wikipedia
	
	remove_column :people, :name
	remove_column :people,  :age
	remove_column :people,  :gender
	remove_column :people,  :twitter
	remove_column :people,  :facebook
	remove_column :people,  :linkedin
	remove_column :people,  :wikipedia
	remove_column :people,  :tumblr
	
	add_column :people, :name, :string, :default => "*"
	add_column :people,  :age, :integer, :default => 0
	add_column :people,  :gender, :boolean, :default => false
	add_column :people,  :twitter, :string, :default => "*"
	add_column :people,  :facebook, :string, :default => "*"
	add_column :people,  :linkedin, :string, :default => "*"
	add_column :people,  :wikipedia, :string, :default => "*"
	add_column :people,  :tumblr, :string, :default => "*"
	
	add_index :people, :facebook
	add_index :people, :linkedin
	add_index :people, :name
	add_index :people, :tumblr 
	add_index :people, :twitter 
	add_index :people, :wikipedia
  end

  def self.down
  	remove_index :people, :facebook
	remove_index :people, :linkedin
	remove_index :people, :name
	remove_index :people, :tumblr 
	remove_index :people, :twitter 
	remove_index :people, :wikipedia
	
	remove_column :people, :name
	remove_column :people,  :age
	remove_column :people,  :gender
	remove_column :people,  :twitter
	remove_column :people,  :facebook
	remove_column :people,  :linkedin
	remove_column :people,  :wikipedia
	remove_column :people,  :tumblr
	
	add_column :people, :name, :string
	add_column :people,  :age, :integer
	add_column :people,  :gender, :boolean
	add_column :people,  :twitter, :string
	add_column :people,  :facebook, :string
	add_column :people,  :linkedin, :string
	add_column :people,  :wikipedia, :string
	add_column :people,  :tumblr, :string
	
	add_index :people, :facebook
	add_index :people, :linkedin
	add_index :people, :name
	add_index :people, :tumblr 
	add_index :people, :twitter 
	add_index :people, :wikipedia
  
  end
end
