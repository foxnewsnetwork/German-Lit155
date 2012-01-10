class ChangePhoneNumberType < ActiveRecord::Migration
  def self.up
	  change_column :phone_records, :phone_number, :string
  end

  def self.down
 	change_column :phone_records, :phone_number, :integer
  end
end
