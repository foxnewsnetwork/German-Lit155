class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  
	include ApplicationHelper	  
	include SearchHelper

  def construct_feed
    @rumors.each do |x|
      userid = x[:user_id]
      if userid.nil?
        x[:username] = 'Anonymous'
      else 
        user = User.find_by_id(userid)
        x[:username] = user[:username]
      end
    end
  end

  def current_user_admin?
    User.find_by_id(current_user.id).admin
  end
  
  def authenticate
    not current_user.nil?
  end
  
end
