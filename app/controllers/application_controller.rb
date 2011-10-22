class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery
  
	include ApplicationHelper	  
	include SearchHelper
end
