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
		if params[:person][:type].nil? || params[:person][:type] != "contact"
			if person.update_attributes( params[:person] )
				flash[:success] = "Update successful!"
			else
				flash[:error] = "Update unsuccessful..."
			end
		else
			if person.update_with_magic( params[:person] )
				flash[:success] = "Contact info updated"
			else
				flash[:error] = "Something went wrong"
			end
		end
		redirect_to :back
	end
	
end
