# == Schema Information
#
# Table name: relationships
#
#  id            :integer(4)      not null, primary key
#  person_id     :integer(4)
#  affliation_id :integer(4)
#  count         :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class Relationship < ActiveRecord::Base
end
