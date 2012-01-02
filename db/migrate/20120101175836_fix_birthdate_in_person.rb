class FixBirthdateInPerson < ActiveRecord::Migration
  def self.up
  	remove_column :people, :birthdate
  	add_column :people, :birthyear, :date, :default => 0
  	add_column :people, :birthmonth, :date, :default => 0
  	add_column :people, :birthday, :date, :default => 0
  end

  def self.down
  	add_column :people, :birthdate, :date
  	remove_column :people, :birthyear
  	remove_column :people, :birthmonth
  	remove_column :people, :birthday
  end
end
