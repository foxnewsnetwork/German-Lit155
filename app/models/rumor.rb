class Rumor < ActiveRecord::Base
  attr_accessible :content, :location, :pic

  location_regex = /\A[0-9]{1,3}.?[0-9]{0,6}[(N|S)]{1}\s?,\s?[0-9]{1,3}.?[0-9]{0,6}[(W|E)]{1}\z/i
  validates :content , :presence => true , 
			:length => { :within => 1..512 }
  validates :location , :presence => true ,
      :format => { :with => location_regex }

  
end
