class CreateAddressRecords < ActiveRecord::Migration
  def self.up
    create_table :address_records do |t|
      t.string :address
      t.integer :person_id
      t.integer :count

      t.timestamps
    end
    add_index :address_records, :address
    add_index :address_records, :person_id
    add_index :address_records, [:address, :person_id], :unique => true
  end

  def self.down
  	remove_index :address_records, :address
  	remove_index :address_records, :person_id
  	remove_index :address_records, [:address, :person_id]
    drop_table :address_records
  end
end
