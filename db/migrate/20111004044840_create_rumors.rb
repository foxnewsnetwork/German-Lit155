class CreateRumors < ActiveRecord::Migration
  def self.up
    create_table :rumors do |t|
      t.text :content
      t.string :location # should be given as longitude and latitude coordinates
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
