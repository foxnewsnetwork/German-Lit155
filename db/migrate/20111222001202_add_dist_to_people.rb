class AddDistToPeople < ActiveRecord::Migration
  def self.up
  	add_column :people, :dist, :integer, :default => 0
  	add_index :people, :dist
  end

  def self.down
  	remove_column :people, :dist
  	remove_index :people, :dist
  end
end
