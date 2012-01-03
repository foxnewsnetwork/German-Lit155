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

	def contact
		if moderator_signed_in?	
			@macropost = current_moderator.macroposts.new
			@moderator = current_moderator
		end
		@mp0 = Macropost.where("board = ? AND section = ?", "contact", "a").paginate( :page => params[:page], :per_page => 10 )
		@mp1 = Macropost.where("board = ? AND section = ?", "contact", "b").paginate( :page => params[:page], :per_page => 10 )
		@mp2 = Macropost.where("board = ? AND section = ?", "contact", "c").paginate( :page => params[:page], :per_page => 10 )
	end
	
	def developer
		if moderator_signed_in?	
			@macropost = current_moderator.macroposts.new
			@moderator = current_moderator			
		end
		@mp0 = Macropost.where("board = ? AND section = ?", "developer", "a").paginate( :page => params[:page], :per_page => 10 )
		@mp1 = Macropost.where("board = ? AND section = ?", "developer", "b").paginate( :page => params[:page], :per_page => 10 )
		@mp2 = Macropost.where("board = ? AND section = ?", "developer", "c").paginate( :page => params[:page], :per_page => 10 )
	end
	
	def about
		if moderator_signed_in?	
			@macropost = current_moderator.macroposts.new
			@moderator = current_moderator			
		end
		@mp0 = Macropost.where("board = ? AND section = ?", "about", "a").paginate( :page => params[:page], :per_page => 10 )
		@mp1 = Macropost.where("board = ? AND section = ?", "about", "b").paginate( :page => params[:page], :per_page => 10 )
		@mp2 = Macropost.where("board = ? AND section = ?", "about", "c").paginate( :page => params[:page], :per_page => 10 )
	end

	def misc
		if moderator_signed_in?	
			@macropost = current_moderator.macroposts.new
			@moderator = current_moderator			
		end
		temp = Macropost.first
		time = temp.nil? ? DateTime.now : temp.created_at
		@mp0 = { :people => Person.count, :rumors => Rumor.count, :time => time }
		@mp1 = Macropost.where("board = ? AND section = ?", "misc", "b").paginate( :page => params[:page], :per_page => 10 )
		@mp2 = Macropost.where("board = ? AND section = ?", "misc", "c").paginate( :page => params[:page], :per_page => 10 )
	end

	def index
		@rumor = Rumor.new
		@latest_rumors = Rumor.find(:all, :order => "created_at DESC", :limit => 3)
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

		unless params[:date].nil? || params[:date].empty?
			temp = params[:date][:search]
			search = search.merge( temp )		
		end

		unless search.nil?
			@people = Rumor.search2(search).paginate( :page => params[:page], :per_page => 1 )
		end
		@search = search		
		@person = Person.new(@search)
		
		# We're currently not doing anything with these, although we should later
		@location = get_coordinates
		@ip = get_ip
		
		if @result.nil?
			flash.now[:notice] = "You haven't spread any rumors yet!"
		end
	end
	
	

end
