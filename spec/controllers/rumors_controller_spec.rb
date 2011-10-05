require 'spec_helper'
require 'factories'

describe RumorsController do

  describe "fail creations" do
      
    before(:each) do
      @attr = { :content => '' , :location => "42.123N,12.412W" }
    end
    
    it "should not create a blank rumor" do
      lambda do
        post :create, :rumor => @attr
      end.should_not change(Rumor, :count)
    end
    
    it "should re-render the page upon failure" do
      post :create, :rumor => @attr
      response.should redirect_to '/'
    end
    
    it "should display a failed flash message" do
      post :create , :rumor => @attr
      flash[:failure] =~ /fail/i
    end
  end
  
  describe "successful creations" do
    before(:each) do
      @attr = { :content => "here is a rumor" , 
      :location => "51.231N,21.321W" }
    end
    
    it "should make create an rumor given correct input" do
      lambda do
        post :create , :rumor => @attr
      end.should change(Rumor, :count).by(1)
    end
    
    it "should redirect back to the home page" do
      post :create , :rumor => @attr
      response.should redirect_to('/')
    end
    
    it "should display a flash message" do
      post :create , :rumor => @attr
      flash[:success] =~ /success/i
    end
    
  end
end
