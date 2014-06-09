require 'json'
require 'open-uri'

class TweetsController < ApplicationController
  include TweetsHelper
  respond_to :json, :html
  
  def index
  	# if you want to read from local file
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)

    #if you want to consume a JSON api file
    # response = open('http://sentimapper.heroku.com/tweets/index.json')
    # @tweets = JSON.parse(File.read(response))
  	
  	# filters for tweets
    if params[:loc]
  	  if params[:min] && params[:max]	
  		  @tweets = Tweet.all.order(sentiment: :asc).where("sentiment >= ? AND sentiment <= ? AND location = ?",params[:min],params[:max],params[:loc])
      else
        @tweets = Tweet.all.order(sentiment: :asc).where("sentiment != 0.0 AND location = ?",params[:loc]) 
      end	
      percentages = calcPiePercentages(@tweets)
      @negpercent = percentages[0]
      @pospercent = percentages[1]
      respond_with @tweets
    else
      if params[:min] && params[:max] 
        @tweets = Tweet.all.order(sentiment: :asc).where("sentiment >= ? AND sentiment <= ?",params[:min],params[:max])
      else
  	    @tweets = Tweet.all.order(sentiment: :asc).where("sentiment != 0.0")
      end
      percentages = calcPiePercentages(@tweets)
      @negpercent = percentages[0]
      @pospercent = percentages[1]
  	  respond_with @tweets
  	end  
  end

end
