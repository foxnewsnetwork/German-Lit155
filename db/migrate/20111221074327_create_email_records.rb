class CreateEmailRecords < ActiveRecord::Migration
  def self.up
    create_table :email_records do |t|
      t.string :email
      t.integer :person_id
      t.integer :count

      t.timestamps
    end
  end

  def self.down
    drop_table :email_records
  end
end
