# == Schema Information
#
# Table name: nickname_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  nickname   :string(255)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class NicknameRecord < ActiveRecord::Base
	belongs_to :person
end
