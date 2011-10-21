class PagesController < ApplicationController
  def home
		@rumor = Rumor.new
		keywords = params[:keywords]
		@rumors = keywords.nil? ? Rumor.all : Rumor.search(keywords)
    temp = @rumors.first
		@location = get_coordinates
    @ip = get_ip
		@initial_zoom = 14

  end

  def about
  end

  def misc
  end

end
