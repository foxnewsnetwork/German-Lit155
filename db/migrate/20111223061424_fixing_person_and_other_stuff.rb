class FixingPersonAndOtherStuff < ActiveRecord::Migration
  def self.up
  	remove_column :people, :lat_avg
  	remove_column :people, :lng_avg
  	
  	add_column :people, :lat_avg, :decimal, :default => 0
  	add_column :people, :lng_avg, :decimal, :default => 0
  	
  	add_index :people, [:lat_avg, :lng_avg]
  end

  def self.down
  	remove_index :people, [:lat_avg, :lng_avg]
  	
  	remove_column :people, :lat_avg
  	remove_column :people, :lng_avg
  	
  	add_column :people, :lat_avg, :integer
  	add_column :people, :lng_avg, :integer
  end
end
