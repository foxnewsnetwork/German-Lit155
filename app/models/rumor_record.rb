# == Schema Information
#
# Table name: rumor_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  rumor_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class RumorRecord < ActiveRecord::Base
	belongs_to :person
	belongs_to :rumor
end
