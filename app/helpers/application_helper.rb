module ApplicationHelper
	
	# Gets the geographic coordinates of the current user
	def get_coordinates
 		my_ip = get_ip
    if(my_ip =~ /\A127/)
      my_ip = "98.207.62.24"
    end
    location =	Geokit::Geocoders::MultiGeocoder.geocode(my_ip)
    return { :lat => location.hash[:lat], :lng => location.hash[:lng] }
	end

	# Gets the IP address of the current user
	def get_ip
		request.remote_ip
	end

end
