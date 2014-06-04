require 'json'

class TweetsController < ApplicationController
  def index
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)
  	@tweets = Tweet.all
  end

  def reload
  	@la_latlong = "-118.575016,33.497282,-117.080875,34.181668"

  	Tweet.delete_all
  	sniffer = TweetSniffer.new(@la_latlong)
  	sniffer.getStream()
  	redirect_to :root
  end

end
