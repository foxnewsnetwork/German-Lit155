class AddPeopleDependenceToRumors < ActiveRecord::Migration
  def self.up
  	add_column :rumors, :person_id, :integer
  	add_index :rumors, :person_id
  end

  def self.down
	remove_index :rumors, :person_id
  	remove_column :rumors, :person_id
  end
end
