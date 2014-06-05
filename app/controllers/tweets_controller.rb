require 'json'

class TweetsController < ApplicationController
  def index
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)
  	@tweets = Tweet.all.where("CAST(sentiment as float) != 0.0")
  end

  def reload
  	redirect_to :root
  end

end
