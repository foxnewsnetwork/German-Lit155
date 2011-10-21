class PagesController < ApplicationController
  def home
		@rumor = Rumor.new
		@rumors = Rumor.all
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
