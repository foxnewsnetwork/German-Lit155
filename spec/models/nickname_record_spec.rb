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

require 'spec_helper'

describe NicknameRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
