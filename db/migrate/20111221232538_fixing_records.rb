class FixingRecords < ActiveRecord::Migration
  def self.up
  	remove_column :ip_records, :ip_id
  	add_column :ip_records, :ip_address, :string
  	add_index :ip_records, :ip_address
  	add_index :ip_records, [:person_id, :ip_address], :unique => true
  	
  	remove_column :phone_records, :phone_id
  	add_column :phone_records, :phone_number, :integer
  	add_index :phone_records, :phone_number
  	add_index :phone_records, [:person_id, :phone_number], :unique => true
  end

  def self.down
	add_column :ip_records, :ip_id, :integer
  	remove_column :ip_records, :ip_address
  	remove_index :ip_records, :ip_address
  	remove_index :ip_records, [:person_id, :ip_address]
  	
  	add_column :phone_records, :phone_id, :integer
  	remove_column :phone_records, :phone_number
  	remove_index :phone_records, :phone_number
  	remove_index :phone_records, [:person_id, :phone_number]
  end
end
