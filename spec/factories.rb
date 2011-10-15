Factory.define :rumor do |rumor|
  rumor.content "Here is a rumor"
  rumor.latitude 41.23 #remember, this is N/S
	rumor.longitude 12.13 #remember, this is W/E
end

Factory.sequence :latitude do |n|
	n + 0.12
end

Factory.sequence :longitude do |n|
	2*n + 0.12
end
