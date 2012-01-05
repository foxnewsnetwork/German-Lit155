# == Schema Information
#
# Table name: tag_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  tag        :string(255)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe TagRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
