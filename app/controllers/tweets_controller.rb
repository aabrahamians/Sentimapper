require 'json'

class TweetsController < ApplicationController
  def index
  	json = File.read(Rails.root + "app/assets/tweets.json")
  	@tweets = JSON.parse(json)
  	puts Rails.root 
  end

end
