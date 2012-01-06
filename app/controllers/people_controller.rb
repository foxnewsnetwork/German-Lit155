class PeopleController < ApplicationController

	# DELETE request
	def destroy
		if moderator_signed_in?
			@person = Person.find_by_id( params[:id] ).destroy
		end
		respond_to do |format|
			format.html { redirect_to root_path }
			format.js
		end
	end
	
	# GET request
	def index
		@people = Person.order( "name DESC" ).paginate( :page => params[:page], :per_page => 50 )
	end

	# Get request
	def show
		@person = Person.find_by_id( params[:id] )
		@rumors = @person.rumors.paginate( :page => params[:page], :per_page => 50 )
		@location = get_coordinates
		@ip = get_ip
	end
		
	# Post request
	def create
		@person = Person.build_with_magic( params[:person] )
		@rumors = @person.rumors.paginate( :page => params[:page], :per_page => 50 )
		@location = get_coordinates
		@ip = get_ip
		unless @person.nil?
			flash[:success] = "New person successfully seeded!"
		else
			flash[:error] = "Couldn't save person for some reason"
		end
		respond_to do |format|
			format.html { redirect_to @person }
			format.js
		end
	end
	
	# Put request
	def update
		person = Person.find_by_id( params[:id] ) 

		# Construct the update vector
		update = params[:person]
		
		# Setting up the @origin string
		@origin = "wikipedia" if params[:person].include?( :wikipedia ) 
		@origin = "tumblr" if params[:person].include?( :tumblr ) 
		@origin = "twitter" if params[:person].include?( :twitter ) 
		@origin = "facebook" if params[:person].include?( :facebook )
		@origin = "linkedin" if params[:person].include?( :linkedin ) 
		@origin = "country" if params[:person].include?( :country )
		@origin = "state" if params[:person].include?( :state )
		@origin = "city" if params[:person].include?( :city )
		@origin = "address" if params[:person].include?( :address )
		@origin = "phone" if params[:person].include?( :phone )								
		@origin = "email" if params[:person].include?( :email )								
		@origin = "nickname" if params[:person].include?( :nickname )

		# Parse the params		
		unless params[:date].nil? || params[:date].empty? || params[:date][:person].nil?
			update = update.merge( params[:date][:person] )
			flash[:notice] = update
			@origin = "birthday-month" if update.include?( :birthmonth )
			@origin = "birthday-day" if update.include?( :birthday )
			@origin = "birthday-year" if update.include?( :birthyear )
		end
		
		@validity = true
		@validity = check_valid?( :wikipedia, params[:person][:wikipedia] ) if params[:person].include?( :wikipedia )
		@validity = check_valid?( :tumblr, params[:person][:tumblr] ) if params[:person].include?( :tumblr ) 
		@validity = check_valid?( :twitter, params[:person][:twitter] ) if params[:person].include?( :twitter ) 
		@validity = check_valid?( :facebook, params[:person][:facebook] ) if params[:person].include?( :facebook ) 
		@validity = check_valid?( :linkedin, params[:person][:linkedin] ) if params[:person].include?( :linkedin ) 
		
		if @validity
			if update[:type].nil? || update[:type] != "contact"
				if person.update_with_magic( update )
					flash[:success] = "Update lolcat successful!"
				else
					flash[:error] = "Something went wrong in lolcat"
				end
			else 
				if person.update_with_magic( update )
					flash[:success] = "Update happycat successful!"
				else
					flash[:error] = "Something went wrong elsewhere"
				end
			end
			@person = person
			@rumors = @person.rumors.paginate( :page => params[:page], :per_page => 50 )
			respond_to do |format|
				format.html { redirect_to :back }
				format.js
			end
		else
			respond_to do |format|
				format.html { redirect_to :back, :notice => "sorry, invalid input" }
				format.js
			end
		end
		
		
	end
	
	private
		# checks validitiy in terms of site names
		def check_valid?( match, url )
			 case match
			 	when :tumblr
					regex = /\A((https?:\/\/[a-zA-Z0-9\.\-_]{0,}\.[a-zA-Z]{1,8}\S{0,})|(\*))\z/
				when :wikipedia
					regex = /\A((https?:\/\/[a-zA-Z0-9\.\-_]{0,}wikipedia\.[a-zA-Z]{1,8}\S{0,})|(\*))\z/
				when :facebook
					regex = /\A((https?:\/\/[a-zA-Z0-9\.\-_]{0,}facebook\.[a-zA-Z]{1,8}\S{0,})|(\*))\z/
				when :twitter
					regex = /\A((https?:\/\/[a-zA-Z0-9\.\-_]{0,}twitter\.[a-zA-Z]{1,8}\S{0,})|(\*))\z/
				when :linkedin
					regex = /\A((https?:\/\/[a-zA-Z0-9\.\-_]{0,}linkedin\.[a-zA-Z]{1,8}\S{0,})|(\*))\z/
			end
			return regex === url
		end
end
