class PeopleController < ApplicationController
	# Get request
	def show
		@person = Person.find_by_id( params[:id] )
		@location = get_coordinates
		@ip = get_ip
	end
		
	# Post request
	def create
		person = Person.build_with_magic( params[:person] )
		unless person.nil?
			flash[:success] = "New person successfully seeded!"
		else
			flash[:error] = "Couldn't save person for some reason"
		end
		redirect_to :back
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
		
		# AJAX implementation
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

		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
		
	end
	
end
