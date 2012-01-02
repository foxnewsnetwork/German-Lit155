class PeopleController < ApplicationController
	
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
		
		# Parse the params		
		unless params[:date].nil? || params[:date].empty? || params[:date][:person].nil?
			update = update.merge( params[:date][:person] )
			flash[:notice] = update
		end
		
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
		redirect_to :back
	end
	
end
