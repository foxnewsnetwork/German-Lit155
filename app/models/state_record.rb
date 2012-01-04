# == Schema Information
#
# Table name: state_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  count      :integer(4)      default(1)
#

class StateRecord < ActiveRecord::Base
	belongs_to :person
	attr_accessible :person_id, :state
	
	def increment_count
	if self.count.nil?
			self.count = 1
		else
			self.count += 1
		end
		self.save!
	end	
end
