require 'json'
require 'open-uri'

class TweetsController < ApplicationController
  def index
  	# if you want to read from local file
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)
  	
  	# filters out sentiments that are 0.0 (no word match)
  	@tweets = Tweet.all.where("CAST(sentiment as float) != 0.0")

  	#if you want to consume a JSON api file
	# response = open('http://sentimapper.heroku.com/tweets/index.json')
	# @tweets = JSON.parse(File.read(response))
  end

  def show
    @tweets = Tweet.all.where("CAST(sentiment as float) != 0.0")
	respond_to do |format|
    	format.html { render :index }
    	format.json { render json: @tweets }
    end
  end

end
