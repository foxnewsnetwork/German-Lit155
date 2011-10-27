class Ip < ActiveRecord::Base
  attr_accessible :rumor_id, :ip
  
  belongs_to :rumor

      
end
