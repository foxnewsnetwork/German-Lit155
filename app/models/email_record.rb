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
end
