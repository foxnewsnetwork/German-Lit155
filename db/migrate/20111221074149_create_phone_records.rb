class CreatePhoneRecords < ActiveRecord::Migration
  def self.up
    create_table :phone_records do |t|
      t.integer :phone_id
      t.integer :person_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :phone_records
  end
end
