require 'spec_helper'

describe TweetsController do
	
		let :valid_attributes do
	   		{
		      :tweet_id => "472858894062985216",
		      :user_name => "Amber Mesker",
		      :text => "Super duper secret creative project for adboom with the talented leviholiman. #hastagads @ Venice Beach http://t.co/XVNt8iHGKc",
		      :latitude => "33.98589209",
		      :longitude => "-118.4727913",
		      :sentiment => "-2",
		      :created_at => "2014-06-07T00:59:35.000Z",
		      :updated_at => "2014-06-07T00:59:35.444Z",
	    	}
  		end

	describe 'GET index' do
	
		before do
			get :index
		end	

		let! :tweet1 do
    		Tweet.create! valid_attributes
    	end

		it 'should render index template' do
			expect(response).to render_template :index
		end

		it "should succeed" do
    		expect(response).to be_success
    	end

		it "should assign tweets to all tweets" do
			expect(assigns(:tweets)).to include(tweet1)
	    end

	end	

	describe "html format" do
      it "should render the index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "json format" do
		let! :tweet1 do
			Tweet.create! valid_attributes
		end

     	it "should render the tweets in json" do
	        get :index, :format => :json
	        expect(JSON.parse(response.body)).to have(1).objects
     	end

     	it "should succeed" do
	        get :index, :format => :json
	        expect(response).to be_success
     	end

     end

     describe "api queries" do
		let! :tweet1 do
			Tweet.create! valid_attributes
		end

     	it "should not return tweets lower than minimum sentiment" do
     		get :index, {min: 2}
     		expect(response).to_not include(tweet1)
     	end

     	it "should return tweets with a maximum sentiment" do
     		get :index, {max:0}
     		expect(response).to_not include(tweet1)
     	end

     end

end



