class ApplicationController < ActionController::Base
  protect_from_forgery
  
	include ApplicationHelper	  
	include SearchHelper
end
