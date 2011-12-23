class AddMoreDetailsToPeople < ActiveRecord::Migration
  def self.up
  	add_column :people, :age, :integer
  	add_column :people, :gender, :boolean # false means female (of course)
  	
  	add_index :people, :name
  end

  def self.down
  	remove_column :people, :age
  	remove_column :people, :gender
  	
  	remove_index :people, :name
  end
end
