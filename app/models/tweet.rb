class Tweet < ActiveRecord::Base

validates_presence_of :tweet_id, :user_name, :latitude, :longitude, :text, :sentiment, :created_at



end
