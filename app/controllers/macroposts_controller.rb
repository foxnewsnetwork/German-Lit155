class MacropostsController < ApplicationController
	before_filter :check_mod

	def create
		unless moderator_signed_in?
			flash[:error] = "You need to be signed in to do this"
			redirect_to :back
			return
		end
		@moderator = current_moderator
		@macropost = @moderator.macroposts.new( params[:macropost] )
		@origin = { :board => params[:macropost][:board], :section => params[:macropost][:section] }
		@macroposts = Macropost.where( "board = ? AND section = ?", @origin[:board], @origin[:section] ).paginate( :page => params[:params], :per_page => 10 )
		if @macropost.save!
			flash[:success] = "macropost successfully saved"
		else
			flash[:error] = "macropost failed"
		end
		
		respond_to do |format|
			format.html { redirect_to :back }
			format.js 
		end

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
		@macropost = Macropost.find_by_id( params[:id] )
		if @macropost.destroy
			flash[:success] = "Macropost successfully deleted"
		else
			flash[:error] = "Something went wrong with deleting"
		end
		
		respond_to do |format|
			format.html { redirect_to :back }
			format.js
		end
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
	
	private
	
		def check_mod
			redirect_to :back, :notice => "wtf sign in" unless moderator_signed_in?
		end
end
