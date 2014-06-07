require 'spec_helper'


describe Tweet do
  it "is valid with a tweet_id, user_name, Latitude, longitude, text, sentiment, created_at" do
  	tweet = Tweet.new(tweet_id: "plain", user_name: "blueberries", latitude: "6.0", longitude: "5.2", text: "fasdf", sentiment: "5",created_at: "20020924", updated_at: 20020924)
  	expect(tweet).to be_valid
  end

	it "is not valid without a tweet_id" do
  	tweet = Tweet.new(user_name: "blueberries", latitude: "6.0", longitude: "5.2", text: "fasdf", sentiment: "5",created_at: "20020924", updated_at: 20020924)
  	expect(tweet).to be_invalid  	
  end  

	it "is not valid without a user_name" do
  	tweet = Tweet.new(tweet_id: "plain",latitude: "6.0", longitude: "5.2", text: "fasdf", sentiment: "5",created_at: "20020924", updated_at: 20020924)
  	expect(tweet).to be_invalid  	
  end 

	it "is not valid without a latitude" do
  	tweet = Tweet.new(tweet_id: "plain", user_name: "blueberries", longitude: "5.2", text: "fasdf", sentiment: "5",created_at: "20020924", updated_at: 20020924)
  	expect(tweet).to be_invalid  	
  end 

	it "is not valid without a longitude" do
  	tweet = Tweet.new(tweet_id: "plain", user_name: "blueberries", latitude: "6.0", text: "fasdf", sentiment: "5",created_at: "20020924", updated_at: 20020924)
  	expect(tweet).to be_invalid  	
  end 

	it "is not valid without a text" do
  	tweet = Tweet.new(tweet_id: "plain", user_name: "blueberries", latitude: "6.0", longitude: "5.2", sentiment: "5",created_at: "20020924", updated_at: 20020924)
  	expect(tweet).to be_invalid  	
  end
	it "is not valid without a sentiment" do
  	tweet = Tweet.new(tweet_id: "plain", user_name: "blueberries", latitude: "6.0", longitude: "5.2", text: "fasdf",created_at: "20020924", updated_at: 20020924)
  	expect(tweet).to be_invalid  	
  end
	it "is not valid without a created_at" do
  	tweet = Tweet.new(tweet_id: "plain", user_name: "blueberries", latitude: "6.0", longitude: "5.2", sentiment: "5", updated_at: 20020924)
  	expect(tweet).to be_invalid  	
  end 
	it "is not valid without a updated_at" do
  	tweet = Tweet.new(tweet_id: "plain", user_name: "blueberries", latitude: "6.0", longitude: "5.2", sentiment: "5",created_at: "20020924")
  	expect(tweet).to be_invalid  	
  end 




end
