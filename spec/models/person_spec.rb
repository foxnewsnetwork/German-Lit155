# == Schema Information
#
# Table name: people
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  dist       :integer(4)      default(0)
#  name       :string(255)     default("*")
#  gender     :boolean(1)      default(FALSE)
#  twitter    :string(255)     default("*")
#  facebook   :string(255)     default("*")
#  linkedin   :string(255)     default("*")
#  wikipedia  :string(255)     default("*")
#  tumblr     :string(255)     default("*")
#  lat_avg    :decimal(15, 10) default(0.0)
#  lng_avg    :decimal(15, 10) default(0.0)
#  birthyear  :date
#  birthmonth :date
#  birthday   :date
#

require 'spec_helper'

describe Person do
  pending "add some examples to (or delete) #{__FILE__}"
end
