class AddCountToStuffWithoutCount < ActiveRecord::Migration
  def self.up
  	add_column :country_records, :count, :integer, :default => 1
  	add_column :state_records, :count, :integer, :default => 1
  	add_column :city_records, :count, :integer, :default => 1  	
  	
  	add_index :phone_records, :person_id
  	add_index :nickname_records, :nickname
  	add_index :nickname_records, [:person_id, :nickname], :unique => true
  	add_index :ip_records, :person_id
  end

  def self.down
	remove_index :phone_records, :person_id
  	remove_index :nickname_records, :nickname
  	remove_index :nickname_records, [:person_id, :nickname]
  	remove_index :ip_records, :person_id  
  	
  	remove_column :country_records, :count
  	remove_column :state_records, :count
  	remove_column :city_records, :count
  end
end
