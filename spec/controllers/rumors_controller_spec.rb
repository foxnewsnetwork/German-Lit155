require 'spec_helper'
require 'factories'

describe RumorsController do

	describe "DELETE 'destroy'" do
		before(:each) do
			@rumor = Factory(:rumor)
		end

		it "should properly delete a rumor" do
			lambda do
				delete :destroy, :id => @rumor.id
			end.should change(Rumor, :count).by(-1)
		end

		it "should display a flash message" do
			delete :destroy, :id => @rumor.id
			flash[:success] =~ /success/i
			response.should redirect_to '/'
		end
	end

	describe "PUT 'update'" do
		before(:each) do
			@rumor = Factory(:rumor)
		end

		it "should properly update the rumor" do
			@attr = { :content => "Here is something new", :longitude => 13.12, :latitude => 31.13 }
			put :update, :id => @rumor.id, :rumor => @attr
			@rumor.content =~ /here is/i
			flash[:success] =~ /success/i
		end
	end

  describe "fail creations" do
      
    before(:each) do
      @attr = { :content => '' , :longitude => 13.12, :latitude => 31.13 }
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
      :longitude => 13.12, :latitude => 31.13 }
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
