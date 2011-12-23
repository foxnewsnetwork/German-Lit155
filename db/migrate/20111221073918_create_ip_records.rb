class CreateIpRecords < ActiveRecord::Migration
  def self.up
    create_table :ip_records do |t|
      t.integer :ip_id
      t.integer :person_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :ip_records
  end
end
