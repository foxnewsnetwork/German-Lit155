class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|

      t.with_options :precision => 15, :scale => 10 do |c|
        c.decimal :latitude
        c.decimal :longitude
      end
      t.integer :user_id
      t.timestamps


    end
    add_index :areas, :user_id

  end

  def self.down
    drop_table :areas
  end
end
