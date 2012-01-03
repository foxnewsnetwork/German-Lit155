class CreateNicknameRecords < ActiveRecord::Migration
  def self.up
    create_table :nickname_records do |t|
      t.integer :person_id
      t.string :nickname
      t.integer :count

      t.timestamps
    end
    
    add_index :nickname_records, :person_id
  end

  def self.down
	remove_index :nickname_records, :person_id
	
    drop_table :nickname_records
  end
end
