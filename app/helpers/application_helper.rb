module ApplicationHelper
	
	# Gets the geographic coordinates of the current user
	def get_coordinates
 		my_ip = get_ip
		if(my_ip =~ /\A127/)
		  my_ip = "98.207.62.24"
		end
		location =	Geokit::Geocoders::MultiGeocoder.geocode(my_ip)
		latitude = location.hash[:lat]
		longitude = location.hash[:lng]
		unless latitude.nil? && longitude.nil?
			return { :lat => location.hash[:lat], :lng => location.hash[:lng] } 
		else
			return { :lat => 0.0, :lng => 0.0 }  
		end
	end

	# Gets the IP address of the current user
	def get_ip
		my_ip ||= request.remote_ip
		my_ip ||= "127.0.0.1"
	end

end
