class CreateStateRecords < ActiveRecord::Migration
  def self.up
    create_table :state_records do |t|
      t.integer :person_id
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :state_records
  end
end
