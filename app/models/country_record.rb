# == Schema Information
#
# Table name: country_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  country    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  count      :integer(4)      default(1)
#

class CountryRecord < ActiveRecord::Base
	belongs_to :person
	attr_accessible :person_id, :country
	
	def increment_count
		if self.count.nil?
			self.count = 1
		else
			self.count += 1
		end
		self.save!

	end	
end
