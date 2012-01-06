# == Schema Information
#
# Table name: comments
#
#  id         :integer(4)      not null, primary key
#  username   :string(255)
#  content    :text
#  section    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
	attr_accessible :content, :section, :username
end
