# == Schema Information
#
# Table name: ip_records
#
#  id         :integer(4)      not null, primary key
#  person_id  :integer(4)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  ip_address :string(255)
#

require 'spec_helper'

describe IpRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
