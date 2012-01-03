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
end
