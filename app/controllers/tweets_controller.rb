require 'json'

class TweetsController < ApplicationController
  def index
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)
  	@tweets = Tweet.all
  end

  def reload
  	redirect_to :root
  end

end
