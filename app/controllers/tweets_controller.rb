require 'json'
require 'open-uri'

class TweetsController < ApplicationController

  respond_to :json, :html
  
  def index





  	# if you want to read from local file
  	# json = File.read(Rails.root + "app/assets/tweets.json")
  	# @tweets = JSON.parse(json)

    #if you want to consume a JSON api file
    # response = open('http://sentimapper.heroku.com/tweets/index.json')
    # @tweets = JSON.parse(File.read(response))
  	
<<<<<<< HEAD
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
=======
  	# filters for tweets
    if params[:loc]
  	  if params[:min] && params[:max]	
  		  @tweets = Tweet.all.order(sentiment: :asc).where("sentiment >= ? AND sentiment <= ? AND location = ?",params[:min],params[:max],params[:loc])
      else
        @tweets = Tweet.all.order(sentiment: :asc).where("sentiment != 0.0 AND location = ?",params[:loc]) 
      end	
      respond_with @tweets
    else
      if params[:min] && params[:max] 
        @tweets = Tweet.all.order(sentiment: :asc).where("sentiment >= ? AND sentiment <= ?",params[:min],params[:max])
      else
  	    @tweets = Tweet.all.order(sentiment: :asc).where("sentiment != 0.0")
      end
  	  respond_with @tweets
  	end
>>>>>>> 37c4e9123d8078f5f2f25156503fd2798c4799ba

  end

end
