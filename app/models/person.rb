# == Schema Information
#
# Table name: people
#
#  id         :integer(4)      not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  dist       :integer(4)      default(0)
#  name       :string(255)     default("*")
#  gender     :boolean(1)      default(FALSE)
#  twitter    :string(255)     default("*")
#  facebook   :string(255)     default("*")
#  linkedin   :string(255)     default("*")
#  wikipedia  :string(255)     default("*")
#  tumblr     :string(255)     default("*")
#  lat_avg    :decimal(15, 10) default(0.0)
#  lng_avg    :decimal(15, 10) default(0.0)
#  birthyear  :date
#  birthmonth :date
#  birthday   :date
#

class Person < ActiveRecord::Base
	include Math # Need the sine function
	has_many :rumor_records, :dependent => :destroy
	has_many :rumors, :through => :rumor_records
	
	has_many :nickname_records, :foreign_key => :person_id, :dependent => :destroy
	
	has_many :phone_records, :foreign_key => :person_id, :dependent => :destroy
	
	has_many :email_records, :foreign_key => :person_id, :dependent => :destroy
	
	has_many :ip_records, :foreign_key => :person_id, :dependent => :destroy
	
	has_many :address_records, :foreign_key => :person_id, :dependent => :destroy
	
	has_many :city_records, :foreign_key => :person_id, :dependent => :destroy
	
	has_many :state_records, :foreign_key => :person_id, :dependent => :destroy

	has_many :country_records, :foreign_key => :person_id, :dependent => :destroy
	
	attr_accessible :dist, :name, :birthyear, :birthmonth, :birthday, :gender, :twitter, :facebook, :linkedin, :wikipedia, :tumblr
	# TODO: use sphinx!

	# Call this function to get a summary on this faggot
	def summary
		out_string = ""
		country = self.country_records.order( "count DESC" ).limit(1).first
		state = self.state_records.order("count DESC").limit(1).first
		city = self.city_records.order("count DESC").limit(1).first
		
		out_string += "probably from " + country.country.capitalize unless country.nil?
		out_string += " current @ " + state.state.capitalize unless state.nil?
		out_string += " in " + city.city.capitalize unless city.nil?
		
		nickname = self.nickname_records.order( "count DESC" ).limit(1).first
		rumor = self.rumors.order( "created_at DESC" ).limit(1).first
		
		out_string += "... also known as \"" + nickname.nickname + "\"" unless nickname.nil?
		out_string += "... latest rumor: " + rumor.content unless rumor.nil? 
		
		out_string += "We've got nothing on this character" if out_string.empty?
		return out_string
	end
		
	# Call this function after spreading a rumor to update the averages
	def update_averages( rumor )
		if self.rumors.empty? || self.rumors.nil?
			self.lat_avg = rumor.latitude
			self.lng_avg = rumor.longitude
		else
			count = self.rumors.count
			self.lat_avg += (rumor.latitude - self.lat_avg) / count
			self.lng_avg += (rumor.longitude - self.lng_avg ) / count
		end
		self.save
	end
	
	# Makes new IP records and stuff
	def update_with_magic( keywords )
		if keywords[:type].nil? || keywords[:type] != "contact"
			self.update_attributes( keywords )
			unless keywords[:birthyear].nil?
				a = Date.new( Integer(keywords[:birthyear]), 1, 1 ) 
				self.update_attributes :birthyear => a
			end
			unless keywords[:birthmonth].nil?
				b = Date.new( 0, Integer(keywords[:birthmonth]), 1 ) 
				self.update_attributes :birthmonth => b
			end
			unless keywords[:birthday].nil?
				c = Date.new( 0, 1, Integer(keywords[:birthday]) )
				self.update_attributes :birthday => c
			end
		else
			self.magic_update_internals( keywords )
		end
	end
		
	# Creates a person... with magic
	def self.build_with_magic( keywords )
		person = Person.new( keywords )
		person.save
		
		person.update_with_magic( keywords )
		return person
	end
	
	# The two functions to call from the rumor model
	# Returns false if the person isn't in the database, returns the person otherwise
	def self.find_by_magic( keywords ) 

		# Step 1: This is quickly going to become unfeasible, but for now we search the entire space
		# Yes, that's right, we hit the entire database. This code is going to be ugly
		internals = { :wildcard_s => "*", :wildcard_i => 0}
		statement = ""
		unless keywords[:name].nil?
			internals = internals.merge( :name => keywords[:name] ) 
			statement += "name = :name OR name = :wildcard_s AND "
		end
		unless keywords[:gender].nil?
			internals = internals.merge( :gender => keywords[:gender] ) 
			statement += "gender = :gender OR age = :wildcard_i AND "
		end
		unless keywords[:facebook].nil?
			internals = internals.merge( :facebook => keywords[:facebook] ) 
			statement += "facebook = :facebook OR facebook = :wildcard_s AND "
		end
		unless keywords[:linkedin].nil?
			internals = internals.merge( :linkedin => keywords[:linkedin] ) 
			statement += "linkedin = :linkedin OR linkedin = :wildcard_s AND "
		end
		unless keywords[:twitter].nil?
			internals = internals.merge( :twitter => keywords[:twitter] ) 
			statement += "twitter = :twitter OR twitter = :wildcard_s AND "
		end
		unless keywords[:tumblr].nil?
			internals = internals.merge( :tumblr => keywords[:tumblr] ) 
			statement += "tumblr = :tumblr OR tumblr = :wildcard_s AND "
		end
		unless keywords[:wikipedia].nil?
			internals = internals.merge( :wikipedia => keywords[:wikipedia] ) 
			statement += "wikipedia = :wikipedia OR wikipedia = :wildcard_s AND "
		end
		
		# We deal with the location
		unless keywords[:latitude].nil? || keywords[:longitude].nil?
			internals = internals.merge( :latitude => keywords[:latitude], :longitude => keywords[:longitude] )
			lat_tol = 1.0 # We're interested in an approximately 70 mile radius around the average
			angle = keywords[:latitude].to_f * PI / 360.0
			lng_tol = 1.0 / ( Math.cos angle ) # People at the north and south poles are fucked
			statement += "lat_avg <= lat_avg + #{lat_tol} AND lat_avg >= lat_avg - #{lat_tol} AND 
				lng_avg <= lng_avg + #{lng_tol} AND lng_avg >= lng_avg - #{lng_tol} AND "
		end
		
		# Handling dates
		unless keywords[:birthyear].nil?
			internals = internals.merge( :birthyear => keywords[:birthyear] )
			statement += "birthyear = :birthyear OR birthyear = :wildcard_i AND "
		end
		unless keywords[:birthmonth].nil?
			internals = internals.merge( :birthmonth => keywords[:birthmonth] )
			statement += "birthmonth = :birthmonth OR birthmonth = :wildcard_i AND "
		end
		unless keywords[:birthday].nil?
			internals = internals.merge( :birthday => keywords[:birthday] )
			statement += "birthday = :birthday OR birthday = :wildcard_i AND "
		end
		
		statement = statement[0..statement.length - 6]
		@people = Person.where( statement, internals ) unless internals.empty?
		
		# TODO: filter by IP address
	end
	
	# Returns a measure (an integer) of the distance between people
	# Essentially a weighed average where certain fields are critically more important
	def self.distance( person1, person2)
		# Step 0: initialize the result
		result = 0
		
		# Step 1: We deal with the biggest players
		weight = 10
		result += self.lolcat(person1.facebook, person2.facebook)  * weight
		result += self.lolcat(person1.twitter, person2.twitter)  * weight
		result += self.lolcat(person1.tumblr, person2.tumblr)  * weight
		result += self.lolcat(person1.linkedin, person2.linkedin)  * weight
		result += self.lolcat(person1.wikipedia, person2.wikipedia) * weight
		
		# Step 2: We measure their names, age, sex
		weight = 5
		result += self.lolcat( person1.name, person2.name ) * weight
		result += self.lolcat( person1.gender, person2.gender) * weight
		result += self.lolcat( person1.birthyear, person2.birthyear) * weight
		result += self.lolcat( person1.birthmonth, person2.birthmonth) * weight
		result += self.lolcat( person1.birthday, person2.birthday) * weight
		
		# Step 3: We measure the other factors
		weight = 1
		result += self.arraycat( person1.ip_addresses, person2.ip_addresses ) * weight
		result += self.arraycat( person1.addresses, person2.addresses ) * weight
		result += self.arraycat( person1.email_addresses, person2.email_addresses) * weight
		result += self.arraycat( person1.phone_numbers, person2.phone_numbers ) * weight
		result += self.arraycat( person1.country, person2.country ) * weight
		result += self.arraycat( person1.state, person2.state ) * weight
		result += self.arraycat( person1.city, person2.city ) * weight
	end
	
	# A more general version of the lolcat thing which works on arrays
	# Note that you can't lose points here as of yet. Considering changing this in the future
	# As you ought t o lose points if the IP addresses are too different
	def self.arraycat(a,b)
		return 0 if a.nil? || b.nil? || a.empty? || b.empty?
		return (a.include?(b.first) ? 1 : 0 ) + self.arraycat( a[1..a.count-1], b[1..b.count-1])
	end
	
	# Returns 1 if a == b, 0 if neither a or b is nil, -1 if a != b
	def self.lolcat( a, b)
		return 1 if a.nil? || b.nil?
		return 0 if a == b
		return 2 if a != b
	end
	
	def distance( person )
		self.distance( self, person )
	end
	
 	#private
		def magic_update_internals( keywords )
			unless keywords[:nickname].nil?
				if record = self.nickname_records.find_by_nickname( keywords[:nickname] ) 
					record.increment_count
				else
					self.nickname_records.create( :nickname => keywords[:nickname] ) 
				end
			end
			unless keywords[:phone].nil?
				if record = self.phone_records.find_by_phone_number( keywords[:phone] ) 
					record.increment_count
				else
					self.phone_records.create( :phone_number => keywords[:phone] ) 
				end
			end
			unless keywords[:email].nil?
				if record = self.email_records.find_by_email( keywords[:email] ) 
					record.increment_count
				else
					self.email_records.create( :email => keywords[:email]) 
				end
			end
			unless keywords[:ip].nil?
				if record = self.ip_records.find_by_ip_address( keywords[:ip] ) 
					record.increment_count
				else
					self.ip_records.create( :ip_address => keywords[:ip]) 
				end
			end
			unless keywords[:address].nil?	
				if record = self.address_records.find_by_address( keywords[:address] ) 
					record.increment_count
				else
					self.address_records.create( :address => keywords[:address]) 
				end
			end
			unless keywords[:city].nil?
				if record = self.city_records.find_by_city( keywords[:city] ) 
					record.increment_count
				else
					self.city_records.create( :city => keywords[:city]) 
				end
			end
			unless keywords[:state].nil?
				if record = self.state_records.find_by_state( keywords[:state] ) 
					record.increment_count
				else
					self.state_records.create( :state => keywords[:state]) 
				end
			end	
			unless keywords[:country].nil?
				if record = self.country_records.find_by_country( keywords[:country] ) 
					record.increment_count
				else			
					self.country_records.create( :country => keywords[:country]) 
				end
			end
		end
end
