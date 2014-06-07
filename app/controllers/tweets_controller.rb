require 'json'
require 'open-uri'

class TweetsController < ApplicationController

  respond_to :json, :html
  
  def index
  	# if you want to read from local file
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)
  	
  	# filters out sentiments that are 0.0 (no word match)
  	if params[:min] && params[:max]	
  		@tweets = Tweet.all.order(sentiment: :asc).where("sentiment >= ? AND sentiment <= ?",params[:min],params[:max])
  		respond_with Tweet.all.order(sentiment: :asc).where("sentiment >= ? AND sentiment <= ?",params[:min],params[:max])	
  	else
  		@tweets = Tweet.all.where("sentiment != 0.0")
  		respond_with @tweets
  	end	

  	#if you want to consume a JSON api file
	# response = open('http://sentimapper.heroku.com/tweets/index.json')
	# @tweets = JSON.parse(File.read(response))
  end

end
