require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = 'TWaKQAMjCCJBJH6Gz8Pp1EeLX'
  config.consumer_secret    = 'CHIS41dDObbEP6aBRl5fOTVTTsg1vKG1ngvvRtA6g52kibEK9s'
  config.oauth_token        = '2518936561-ZTI6mTh4uaJaL8c3Llo4ARr6dX4zygx7LbrPcIe'
  config.oauth_token_secret = 'tbY7jzEOma0Y5hxSBBrtTqW9khF7ikKGWG0lj79YIC1co'
  config.auth_method        = :oauth
end

client = TweetStream::Client.new

client.on_error do |message|
  puts message
end

# client.locations("-122.75,36.8,-121.75,37.8") do |status|
  client.locations("-118.516100,33.978320,-118.377740,34.087006") do |status|
  puts "#{status.text}"
end