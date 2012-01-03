# == Schema Information
#
# Table name: state_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  state      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  count      :integer(4)      default(1)
#

require 'spec_helper'

describe StateRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
