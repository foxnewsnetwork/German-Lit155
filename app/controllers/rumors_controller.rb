class RumorsController < ApplicationController
  before_filter :check_admin , :only => [ :destroy ]

  def create
    @rmr = Rumor.new(params[:rumor])
    if @rmr.save
	    flash[:success] = "Rumor successfully spread"
    else
	    flash[:failure] = "Something went wrong"
    end
    redirect_to '/'
  end

  def destroy

  end
  
  def new
  
  end

  private

    def check_admin

    end

end
