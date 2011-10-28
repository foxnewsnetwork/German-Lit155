class RumorsController < ApplicationController
  
  before_filter :authenticate, :only => [ :destroy, :edit, :update]
  before_filter :correct_user, :only => [ :edit, :update]
  before_filter :check_admin , :only => :destroy

  def create
    if logged_in?
      @rmr = current_user.rumors.build(params[:rumor])
    else
      @rmr = Rumor.new(params[:rumor])
    end

    if @rmr.latitude.nil? 
		  loc = get_coordinates
  		@rmr.latitude = loc[:lat]
    	@rmr.longitude = loc[:lng]
    end

    if @rmr.save
	    flash[:success] = "Rumor successfully spread"
    else
	    flash[:failure] = "Something went wrong"
    end

    @lat = @rmr[:latitude]
    @long = @rmr[:longitude]
    @rumors = Rumor.all
    @users = User.all
    @feed = construct_feed
    
    @IP = Ip.new(:rumor_id => @rmr.id, :ip=>get_ip.to_s)
    @IP.save
    
    respond_to do |format|
      format.html {redirect_to "/"}
      format.js
    end
  end

  def destroy
    rumor = Rumor.find_by_id(params[:id])
    @lat = rumor[:latitude]
    @long = rumor[:longitude]
    @title = rumor.title
    rumor.destroy
    ip = Ip.find_by_id(params[:id])
    ip.destroy
    flash[:success] = "Rumor successfully deleted"
    @rumors = Rumor.all
    @feed = construct_feed
    @count = params[:counter]
    puts(@count)
    respond_to do |format|
         format.html {redirect_to "/"}
         format.js
      end  
    end

  def new
    @rumor = Rumor.new
    @title = "Spread a new rumor?"
  end

  def update 
    @rumor = Rumor.find_by_id(params[:id])
    if @rumor.update_attributes(params[:rumor])
      flash[:success] = "Rumor successfully updated"
      redirect_to '/'
    else
      @title = "Edit rumor"
      render 'edit'
    end
  end

	def edit
    @title = "Edit rumor"	
	end

  private
    def authenticate
      deny_access unless logged_in?
    end
    
    def correct_user
      @user = User.find(params[:id])

      unless current_user?(@user)
        puts 'Current User did not pass'
      end
    end

    def check_admin
      # implement this once we get the user resource and model
      unless current_user_admin?
        puts 'Check Admin did not pass'
      end
    end

end
