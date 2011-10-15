class CreateRumors < ActiveRecord::Migration
  def self.up
    create_table :rumors do |t|
      t.text :content
      t.float :latitude # N/S 
      t.float :longitude # W/E
      t.boolean :gmaps
      t.integer :zoom_level , :default => 1
      t.integer :parent_id
      t.string :pic

      t.timestamps
    end
  end

  def self.down
    drop_table :rumors
  end
end
