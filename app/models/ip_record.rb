# == Schema Information
#
# Table name: ip_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  ip_address :string(255)
#

class IpRecord < ActiveRecord::Base
	belongs_to :person
end
