# == Schema Information
#
# Table name: address_records
#
#  id         :integer(4)      not null, primary key
#  address    :string(255)
#  person_id  :integer(4)
#  count      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe AddressRecord do
  pending "add some examples to (or delete) #{__FILE__}"
end
