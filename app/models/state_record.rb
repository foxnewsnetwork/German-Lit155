# == Schema Information
#
# Table name: state_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class StateRecord < ActiveRecord::Base
	belongs_to :person
end
