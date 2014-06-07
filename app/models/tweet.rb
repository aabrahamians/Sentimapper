class Tweet < ActiveRecord::Base

validates_presence_of :tweet_id, :user_name, :latitude, :longitude, :text, :sentiment, :created_at

validates_numericality_of :sentiment, :greater_than_or_equal_to => -5.0, :less_than_or_equal_to => 5.0
validates_numericality_of :latitude, :greater_than_or_equal_to => -90.0, :less_than_or_equal_to => 90.0
validates_numericality_of :longitude, :greater_than_or_equal_to => -180.0, :less_than_or_equal_to => 180.0

end
