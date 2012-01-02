class AddIndexToCityStateCountry < ActiveRecord::Migration
  def self.up
  	add_index :city_records, :person_id
  	add_index :state_records, :person_id
  	add_index :country_records, :person_id
	  	
  	add_index :city_records, :city
  	add_index :state_records, :state
  	add_index :country_records, :country
  	
  	add_index :city_records, [:person_id, :city], :unique => true
  	add_index :state_records, [:person_id, :state], :unique => true
  	add_index :country_records, [:person_id, :country], :unique => true
  	
  	remove_column :people, :country
  	remove_column :people, :state
  	remove_column :people, :city
  end

  def self.down
  	remove_index :city_records, :person_id
  	remove_index :state_records, :person_id
  	remove_index :country_records, :person_id  

  	remove_index :city_records, :city
  	remove_index :state_records, :state
  	remove_index :country_records, :country  	
  	
	remove_index :city_records, [:person_id, :city]
  	remove_index :state_records, [:person_id, :state]
  	remove_index :country_records, [:person_id, :country]
  	
  	add_column :people, :country, :string, :default => "*"
  	add_column :people, :state, :string, :default => "*"
  	add_column :people, :city, :string, :default => "*"
  end
end
