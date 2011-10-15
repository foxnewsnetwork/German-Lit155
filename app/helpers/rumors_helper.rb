module RumorsHelper
	
	def maps_json_1
		# Eventually I need to do this so only a small bit of the data is withdrawn
		@json = '[
							{ 
								"description": "",
								"title": "",
								"sidebar": "",
								"lng":"",
								"lat":"",
								"picture":"",
								"width":"",
								"height":"" 						
							},
							{
								"lng": "'+ + '",
								"lat": "'+ + '"
							}
						]' 
	end

	def maps_json_2
		@json = Rumor.all.to_gmaps4rails do |rumor, marker|
			marker.picture({
										:picture => "http://www.blankdots.com/img/github-32x32.png",
										:width => "32",
										:height => "32"
										})
			marker.title "title here"
			marker.sidebar "sidebar here"
			marker.json "\"id\": #{rumor.id}"
			marker.lat "#{rumor.latitude}"
			marker.lng "#{rumor.longitude}"
		end
	end
end
