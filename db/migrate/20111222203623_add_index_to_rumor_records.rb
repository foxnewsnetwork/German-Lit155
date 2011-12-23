class AddIndexToRumorRecords < ActiveRecord::Migration
  def self.up
  	add_index :rumor_records, :person_id
  	add_index :rumor_records, :rumor_id
  	add_index :rumor_records, [:person_id, :rumor_id], :unique => true
  end

  def self.down
  	remove_index :rumor_records, :person_id
  	remove_index :rumor_records, :rumor_id
  	remove_index :rumor_records, [:person_id, :rumor_id]
  end
end
