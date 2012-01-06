class CommentsController < ApplicationController
	# POST
  def create
  	if params[:comment].nil? || params[:comment][:content].nil? || params[:comment][:section].nil?
  		flash[:notice] = "Stop trying to mass-assign crap"
  		redirect_to :back
  		return
  	end
  	params[:comment][:content] = "I'm a stupid faggot who tries to blank post" if params[:comment][:content].empty?
  	if moderator_signed_in?
	  	@comment = Comment.new( :username => "admin => toche", :section => params[:comment][:section], :content => params[:comment][:content]  )
	else
		ip = get_ip
		@comment = Comment.new( :username => ip, :section => params[:comment][:section], :content => params[:comment][:content]  )
	end
	@comment.save!
	@origin = params[:comment][:section]
	@comments = Comment.where( :section => @origin ).limit(100).paginate( :page => params[:page], :per_page => 25 )
	@cnew = Comment.new
	respond_to do |format|
		format.html { redirect_to :back }
		format.js
	end  	
  end

	# DELETE
  def destroy
  	@comment = Comment.find(params[:id]).destroy
  	respond_to do |format|
  		format.html { redirect_to :back }
  		format.js
  	end
  end

end
