# == Schema Information
#
# Table name: areas
#
#  id         :integer(4)      not null, primary key
#  latitude   :decimal(15, 10)
#  longitude  :decimal(15, 10)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Area < ActiveRecord::Base
  belongs_to :user

end
