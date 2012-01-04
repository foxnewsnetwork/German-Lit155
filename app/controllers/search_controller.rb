class SearchController < ApplicationController

	def create
		@keywords = params[:search]
		@results = sphinx_search(@keywords)
	end

end
