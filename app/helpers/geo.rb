require 'rubygems'
require 'geokit'
require 'pp'

include Geokit::Geocoders
my_ip ='136.152.36.234'

location = Geokit::Geocoders::MultiGeocoder.geocode(my_ip)
puts location
