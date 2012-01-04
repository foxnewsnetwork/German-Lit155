# == Schema Information
#
# Table name: address_records
#
#  id         :integer(4)      not null, primary key
#  address    :string(255)
#  person_id  :integer(4)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class AddressRecord < ActiveRecord::Base
	belongs_to :person
	attr_accessible :person_id, :address
	
	def increment_count
		if self.count.nil?
			self.count = 1
		else
			self.count += 1
		end
		self.save!
	end
end
