class RumorsController < ApplicationController
 	before_filter :check_mod, :only => :destroy
 	
	def create
		@rumor = Rumor.new(params[:rumor])
		unless @rumor.save!
			@error = "Unable to save"
			 redirect_to @person, :notice => @error
		end
		@rumor.rumor_records.create( :person_id => params[:rumor][:person] )
		@person = Person.find_by_id( params[:rumor][:person] )
		@person.update_averages(@rumor)
		respond_to do |format|
			format.html { redirect_to @person }
			format.js
		end
	end
	
	def destroy
		@rumor = Rumor.find_by_id(params[:id])
		@person = @rumor.people.first
		if @rumor.destroy
			flash[:success] = "done"
		else
			flash[:error] = "nope"
		end
		respond_to do |format|
			format.html { redirect_to @person }
			format.js		
		end
	end
	
	private
	
		def check_mod
			redirect_to root_path, :notice => "Please don't try to arbitrarily delete stuff" unless moderator_signed_in?
		end

end
