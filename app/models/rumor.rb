class Rumor < ActiveRecord::Base
  attr_accessible :content, :latitude, :longitude, :pic, :gmaps

  validates :content , :presence => true , 
			:length => { :within => 1..512 }
  validates :latitude , :presence => true 
  validates :longitude , :presence => true 
	
	acts_as_gmappable :process_geocoding => false, :lat => "latitude", :lng => "longitude"
  
  before_save :stagger_location

	# Sphinx-use index section
	define_index do
    # Fields
    indexes content
    
    # Attributes
    has created_at, updated_at, parent_id, latitude, longitude
	end
  
  # returns the first 50 characters or the first 5 words of a rumor
  def title
    f50 = self.content.length > 50 ? self.content[0..49] : self.content
    if self.content.length > 50
      f50 = self.content[0..49]
      f50s = f50.split(' ')
      if f50s.length > 6
        return f50s[0..4].join(" ") + "..."
      else
        return f50s[0..f50s.length-2].join(" ") + "..."
      end
    else
      return f50
    end
    
    return "#{f50}" if f50s.length < 5
    outS = ''
    for j in 0..4
      outS += f50s[j]
    end
    return "#{outS}..." unless outS.length > 50
    return "#{f50}..."
  end
  
  private
    	
    # location had better be a hash for :lat and :lng
    # we stagger for a radius of 0.5 km on the earth surface
    def stagger_location
      scale_constant = 9.567e-4 # theta = what I want to look good 
      d_a = [rand(20) - 10.0, rand(20) - 10.0] # two random numbers between -10 and 10
      d_p = [d_a[0]/10.0 , d_a[1]/10.0] # two random numbers between -1 and 1

      self.latitude += scale_constant * d_p[0]
      self.longitude += scale_constant * d_p[1]
    end
end
