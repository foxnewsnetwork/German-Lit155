class CreateCityRecords < ActiveRecord::Migration
  def self.up
    create_table :city_records do |t|
      t.integer :person_id
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :city_records
  end
end
