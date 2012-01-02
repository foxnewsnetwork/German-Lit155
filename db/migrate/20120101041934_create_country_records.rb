class CreateCountryRecords < ActiveRecord::Migration
  def self.up
    create_table :country_records do |t|
      t.integer :person_id
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :country_records
  end
end
