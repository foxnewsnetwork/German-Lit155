# == Schema Information
#
# Table name: rumors
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  latitude   :decimal(15, 10)
#  longitude  :decimal(15, 10)
#  gmaps      :boolean(1)
#  zoom_level :integer(4)      default(1)
#  parent_id  :integer(4)
#  pic        :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  person_id  :integer(4)
#

require 'spec_helper'

describe Rumor do
  pending "add some examples to (or delete) #{__FILE__}"


	describe "validations" do
		before(:each) do
			@attr = { :content => "stuff",
				:location => "53.121 N, 12.3123 W" }
		end
	end
end
