class CreateRumorRecords < ActiveRecord::Migration
  def self.up
    create_table :rumor_records do |t|
      t.integer :person_id
      t.integer :rumor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rumor_records
  end
end
