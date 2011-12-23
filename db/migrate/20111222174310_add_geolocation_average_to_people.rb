class AddGeolocationAverageToPeople < ActiveRecord::Migration
  def self.up
  	add_column :people, :lat_avg, :decimal
  	add_column :people, :lng_avg, :decimal
  	
  	add_index :people, [:lat_avg, :lng_avg]
  end

  def self.down
	remove_column :people, :lat_avg
  	remove_column :people, :lng_avg
  	
  	remove_index :people, [:lat_avg, :lng_avg]
  end
end
