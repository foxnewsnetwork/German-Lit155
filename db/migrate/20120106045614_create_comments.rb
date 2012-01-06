class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :username
      t.text :content
	  t.string :section
	  	
      t.timestamps
    end
    
    add_index :comments, :section
  end

  def self.down
  	remove_index :comments, :section
    drop_table :comments
  end
end
