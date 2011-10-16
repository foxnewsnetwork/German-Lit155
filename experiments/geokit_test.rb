require 'rubygems'
require 'geokit'
require 'pp'
include Geokit::Geocoders

my_ip = "98.207.62.24"

@my_loc = Geokit::Geocoders::MultiGeocoder.geocode(my_ip)

puts @my_loc
puts @my_loc.hash[:lat]
puts @my_loc.hash[:lng]
puts @my_loc.class
