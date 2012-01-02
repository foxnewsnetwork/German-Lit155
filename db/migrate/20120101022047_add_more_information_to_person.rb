class AddMoreInformationToPerson < ActiveRecord::Migration
  def self.up
  	remove_column :people, :age
  	add_column :people, :birthdate, :date
  	
  	add_column :people, :country, :string, :default => "*"
  	add_column :people, :state, :string, :default => "*"
  	add_column :people, :city, :string, :default => "*"
  	
  	remove_index :people, [:lat_avg, :lng_avg]
  	remove_column :people, :lat_avg
  	remove_column :people, :lng_avg
  	
  	add_column :people, :lat_avg, :decimal, :precision => 15, :scale => 10, :default => 0.0
  	add_column :people, :lng_avg, :decimal, :precision => 15, :scale => 10, :default => 0.0
  end

  def self.down
  	add_column :people, :age, :integer
  	remove_column :people, :birthdate, :date
  	
  	remove_column :people, :country
  	remove_column :people, :state
  	remove_column :people, :city
  	
  	remove_column :people, :lat_avg
  	remove_column :people, :lng_avg
  	
  	add_column :people, :lat_avg, :decimal, :default => 0
  	add_column :people, :lng_avg, :decimal, :default => 0
  	add_index :people, [:lat_avg, :lng_avg]
  end
end
