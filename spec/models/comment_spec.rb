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

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
