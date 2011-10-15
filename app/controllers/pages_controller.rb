class PagesController < ApplicationController
  def home
		@rumor = Rumor.new
		@rumors = Rumor.all
    temp = @rumors.first
		@location = { :zoom => temp.zoom_level, :lat => temp.latitude , :lng => temp.longitude }
  end

  def about
  end

  def misc
  end

end
