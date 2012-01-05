class CreateTagRecords < ActiveRecord::Migration
  def self.up
    create_table :tag_records do |t|
      t.integer :person_id
      t.string :tag
      t.integer :count

      t.timestamps
    end
    
    add_index :tag_records, :person_id
    add_index :tag_records, :tag
    add_index :tag_records, [:person_id, :tag], :unique => true
  end

  def self.down
	add_index :tag_records, :person_id
	add_index :tag_records, :tag
	add_index :tag_records, [:person_id, :tag]
  
    drop_table :tag_records
  end
end
