class CreateIps < ActiveRecord::Migration
  def self.up
    create_table :ips do |t|
      t.integer :rumor_id
      t.string :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :ips
  end
end
