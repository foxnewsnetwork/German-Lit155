class PagesController < ApplicationController
  def home
		@rumor = Rumor.new
		@rumors = Rumor.all
    temp = @rumors.first
		@location = get_coordinates
		@initial_zoom = 13
  end

  def about
  end

  def misc
  end

end
