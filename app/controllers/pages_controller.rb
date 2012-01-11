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
		# Section 1: Initializing Required Instances
		@latest_rumors = Rumor.find(:all, :order => "created_at ASC", :limit => 3).reverse
		@location = get_coordinates
		@ip = get_ip
		@search = params[:search]
		
		# Parsing the date section
		unless params[:date].nil? || params[:date].empty?
			temp = params[:date][:search]
			@search = @search.merge( temp )		
		end

		unless @search.nil?
			@people = Person.find_by_magic(@search).paginate( :page => params[:page], :per_page => 10 )
			@purpose = "search results"
		end
		@person = Person.new(@search)
		
		@remote = true
		respond_to do |format|
			format.html 
			format.js
		end
	end
	
	def discussion
		@c1 = Comment.where(:section => "a").limit(100).paginate( :page => params[:page], :per_page => 25 )
		@c2 = Comment.where(:section => "b").limit(100).paginate( :page => params[:page], :per_page => 25 )
		@c3 = Comment.where(:section => "c").limit(100).paginate( :page => params[:page], :per_page => 25 )
		@cnew = Comment.new
	end	
	

end
