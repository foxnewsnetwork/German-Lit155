# == Schema Information
#
# Table name: people
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  dist       :integer(4)      default(0)
#  name       :string(255)     default("*")
#  age        :integer(4)      default(0)
#  gender     :boolean(1)      default(FALSE)
#  twitter    :string(255)     default("*")
#  facebook   :string(255)     default("*")
#  linkedin   :string(255)     default("*")
#  wikipedia  :string(255)     default("*")
#  tumblr     :string(255)     default("*")
#  lat_avg    :integer(10)
#  lng_avg    :integer(10)
#

require 'spec_helper'

describe Person do
  pending "add some examples to (or delete) #{__FILE__}"
end
