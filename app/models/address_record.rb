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
end
