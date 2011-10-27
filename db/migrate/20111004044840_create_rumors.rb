class CreateRumors < ActiveRecord::Migration
  def self.up
    create_table :rumors, :options=>"ENGINE=MyISAM", :force => true do |t|
      t.text :content
      #t.float :latitude, :precision => 15 # N/S 
      #t.float :longitude, :precision => 15 # W/E
      
      t.with_options :precision => 15, :scale => 10 do |c|
        c.decimal :latitude
        c.decimal :longitude
      end

      t.boolean :gmaps
      t.integer :zoom_level , :default => 1
      t.integer :parent_id
      t.string :pic
      t.integer :user_id

      t.timestamps
    end
    add_index :rumors, :user_id
  end

  def self.down
    drop_table :rumors
  end
end
