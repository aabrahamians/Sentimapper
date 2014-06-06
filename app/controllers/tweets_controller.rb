require 'json'
require 'open-uri'

class TweetsController < ApplicationController
  def index
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)
  	# @tweets = Tweet.all.where("CAST(sentiment as float) != 0.0")

	response = open('http://sentimapper.heroku.com/tweets/index.json')
	@tweets = JSON.parse(response)
  end

  def show
    @tweets = Tweet.all.where("CAST(sentiment as float) != 0.0")
	respond_to do |format|
    	format.html { }
    	format.json { render json: @tweets }
    end
  end

  def reload
  	redirect_to :root
  end

end
