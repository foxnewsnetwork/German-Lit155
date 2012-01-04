# == Schema Information
#
# Table name: rumors
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  latitude   :decimal(15, 10)
#  longitude  :decimal(15, 10)
#  gmaps      :boolean(1)
#  zoom_level :integer(4)      default(1)
#  parent_id  :integer(4)
#  pic        :string(255)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  person_id  :integer(4)
#

class Rumor < ActiveRecord::Base
  attr_accessible :content, :latitude, :longitude, :pic, :gmaps

  validates :content , :presence => true , 
			:length => { :within => 1..512 }
  validates :latitude , :presence => true 
  validates :longitude , :presence => true 
  default_scope :order => 'created_at DESC'
  scope :from_users_followed_by, lambda { |user| followed_by(user) }


  acts_as_gmappable :process_geocoding => false, :lat => "latitude", :lng => "longitude"
  
#  before_save :stagger_location
  
  has_many :rumor_records, :dependent => :destroy
  has_many :people, :through => :rumor_records

	# Sphinx-use index section
	#define_index do
    # Fields
    #indexes content
    
    # Attributes
   # has created_at, updated_at, parent_id, latitude, longitude
#	end
	
	def self.spread( keywords ) 
		# Step 1: Initialize the people in question
		people = Person.find_by_magic( keywords )

		if people.empty?
			person = Person.build_with_magic( keywords )
			rumor = person.rumors.new( :content => keywords[:content], :latitude => keywords[:latitude], :longitude => keywords[:longitude])
			rumor.save!
			rumor_record = rumor.rumor_records.create( :person_id => person.id )
			person.update_averages(rumor)
		else
			rumor = Rumor.create( :content => keywords[:content], :latitude => keywords[:latitude], :longitude => keywords[:longitude] )
			people.each do | person |
				rumor_record = rumor.rumor_records.create( :person_id => person.id )
				person.update_averages(rumor)
			end
		end
	end
	
	def self.search2( keywords )
		# Step 1: initialize the people who might be of interest
		people = Person.find_by_magic( keywords )
		return people 
	end

  #def self.followed_by(user)
   #area_ids = %(SELECT area_id FROM areas
   #               WHERE area_id = :user_id)
   #where("user_id IN (#{following_ids}) OR user_id = :user_id",
   #         { :user_id => user })
  #end
  
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
    # we stagger for a radius of some km on the earth surface
    def stagger_location
      scale_constant = 9.567e-5# theta = what I want to look good 
      d_a = [rand(20) - 10.0, rand(20) - 10.0] # two random numbers between -10 and 10
      d_p = [d_a[0]/10.0 , d_a[1]/10.0] # two random numbers between -1 and 1

      self.latitude += scale_constant * d_p[0]
      self.longitude += scale_constant * d_p[1]
    end
end
