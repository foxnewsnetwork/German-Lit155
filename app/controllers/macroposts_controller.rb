class MacropostsController < ApplicationController
	def create
		unless moderator_signed_in?
			flash[:error] = "You need to be signed in to do this"
			redirect_to :back
			return
		end
		moderator = current_moderator
		macropost = moderator.macroposts.new( params[:macropost] )
		if macropost.save!
			flash[:success] = "macropost successfully saved"
		else
			flash[:error] = "macropost failed"
		end
		redirect_to :back
	end
	
	def edit
		unless moderator_signed_in?
			flash[:error] = "You need to be signed in to do this"
			redirect_to :back
			return
		end
		@macropost = Macropost.find_by_id( params[:id] )
	end
		
	def destroy
		unless moderator_signed_in?
			flash[:error] = "You need to be signed in to do this"
			redirect_to :back
			return
		end
		
		moderator = current_moderator
		macropost = Macropost.find_by_id( params[:id] )
		if macropost.destroy
			flash[:success] = "Macropost successfully deleted"
		else
			flash[:error] = "Something went wrong with deleting"
		end
			redirect_to :back
	end
	
	def update
		unless moderator_signed_in?
			flash[:error] = "You need to be signed in to do this"
			redirect_to :back
			return
		end
		macropost = Macropost.find_by_id( params[:id] )
		if macropost.update_attributes( params[:macropost] )
			flash[:success] = "update successful"
		else
			flash[:error] = "update failed"
		end
		redirect_to root_path
	end
end
