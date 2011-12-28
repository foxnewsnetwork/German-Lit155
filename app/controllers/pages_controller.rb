class PagesController < ApplicationController
  def home
		@rumor = Rumor.new
		keywords = params[:keywords]
		@rumors = keywords.nil? ? Rumor.all : Rumor.search(keywords)
    @feed = construct_feed
    temp = @rumors.first
		@location = get_coordinates
    @ip = get_ip
		@initial_zoom = 14

  end

  def about
  end

  def misc
  end

	def index
		@rumor = Rumor.new

		unless params[:rumor].nil?
			if params[:rumor][:type] == "#"
				rmr = Rumor.create(params[:rumor])
				rmr.rumor_records.create( :person_id => params[:rumor][:person] )
				prs = Person.find_by_id( params[:rumor][:person] )
				prs.update_averages(rmr)
				redirect_to :back
			else
				spread = params[:rumor]
				@result = Rumor.spread(spread) unless spread.nil?
			end
		end
		search = params[:search]

		unless search.nil?
			@people = Rumor.search2(search).paginate(:page => 1) 
		end
		@search = search		
		@person = Person.new(@search)
		
		# We're currently not doing anything with these, although we should later
		@location = get_coordinates
		@ip = get_ip
		
		if @result.nil?
			flash.now[:error] = "Sorry, something went wrong with spreading your rumor"
		end
	end
	
	

end
