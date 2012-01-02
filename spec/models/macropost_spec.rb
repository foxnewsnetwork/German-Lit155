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

require 'spec_helper'

describe Macropost do
  pending "add some examples to (or delete) #{__FILE__}"
end
