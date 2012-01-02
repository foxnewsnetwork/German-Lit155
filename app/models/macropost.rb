# == Schema Information
#
# Table name: macroposts
#
#  id           :integer(4)      not null, primary key
#  moderator_id :integer(4)
#  content      :text
#  board        :string(255)
#  section      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Macropost < ActiveRecord::Base
	belongs_to :moderator
end
