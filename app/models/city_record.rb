# == Schema Information
#
# Table name: city_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  city       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  count      :integer(4)      default(1)
#

class CityRecord < ActiveRecord::Base
	belongs_to :person
end
