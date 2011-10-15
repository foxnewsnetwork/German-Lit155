class Rumor < ActiveRecord::Base
  attr_accessible :content, :latitude, :longitude, :pic, :gmaps

  validates :content , :presence => true , 
			:length => { :within => 1..512 }
  validates :latitude , :presence => true 
  validates :longitude , :presence => true 
	
	acts_as_gmappable :process_geocoding => false, :lat => "latitude", :lng => "longitude"
end
