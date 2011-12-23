# == Schema Information
#
# Table name: phone_records
#
#  id           :integer(4)      not null, primary key
#  person_id    :integer(4)
#  count        :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  phone_number :integer(4)
#

class PhoneRecord < ActiveRecord::Base
	belongs_to :person
end
