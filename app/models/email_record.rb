# == Schema Information
#
# Table name: email_records
#
#  id         :integer(4)      not null, primary key
#  email      :string(255)
#  person_id  :integer(4)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class EmailRecord < ActiveRecord::Base
	belongs_to :person
	attr_accessible :person_id, :email
	
	def increment_count
		if self.count.nil?
			self.count = 1
		else
			self.count += 1
		end
		self.save!

	end	
end
