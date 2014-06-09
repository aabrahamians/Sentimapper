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
  		
        neg = 0.0
        post = 0.0

        @tweets.each do |t|
          if t["sentiment"] < 0
            neg += 1
          elsif t["sentiment"] > 0
            post += 1
          end
          puts neg
          puts post

        end



        if neg > 0 && post > 0
        @negpercent = neg/(neg+post)
        @pospercent = post/(neg+post)
        end

        puts @negpercent
        puts @pospercent


      respond_with @tweets
  	end	

  	#if you want to consume a JSON api file
	# response = open('http://sentimapper.heroku.com/tweets/index.json')
	# @tweets = JSON.parse(File.read(response))
  end

end
