class RumorsController < ApplicationController
  before_filter :check_admin , :only => [ :destroy, :edit, :update ]

  def create
    @rmr = Rumor.new(params[:rumor])
		loc = get_coordinates
    
		@rmr.latitude = loc[:lat]
		@rmr.longitude = loc[:lng]
    if @rmr.save
	    flash[:success] = "Rumor successfully spread"
    else
	    flash[:failure] = "Something went wrong"
    end
       @lat = @rmr[:latitude]
    @long = @rmr[:longitude]
    @rumors = Rumor.all
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
    flash[:success] = "Rumor successfully deleted"
    @rumors = Rumor.all
     @count = params[:counter]
    puts(@count)
      respond_to do |format|
         format.html {redirect_to "/"}
         format.js
       end  end
  
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

    def check_admin
      # implement this once we get the user resource and model
    end

end
