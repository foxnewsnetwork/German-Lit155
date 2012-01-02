class CreateMacroposts < ActiveRecord::Migration
  def self.up
    create_table :macroposts do |t|
      t.integer :moderator_id
      t.text :content
      t.string :board
      t.string :section

      t.timestamps
    end
  end

  def self.down
    drop_table :macroposts
  end
end
