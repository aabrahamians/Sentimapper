require 'rubygems'
require 'oauth'
require 'json'

# Now you will fetch /1.1/statuses/user_timeline.json,
# returns a list of public Tweets from the specified
# account.
baseurl = "https://api.twitter.com"
path    = "/1.1/search/tweets.json"
geocode = "34.032471,-118.475407,5mi"

query   = URI.encode_www_form(
    "count" => 50,
    "geocode" => geocode,
    "lang" => "en",
    "q" => ""
)
# address = URI("#{baseurl}#{path}?#{query}")
address = URI("#{baseurl}#{path}?#{query}")
puts address
request = Net::HTTP::Get.new address.request_uri

# Print data about a list of Tweets
def print_timeline(tweets)
  # ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    tweets.each do |t|
        # puts t["coordinates"]
        puts t.text
    end
end

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

# If you entered your credentials in the first
# exercise, no need to enter them again here. The
# ||= operator will only assign these values if
# they are not already set.
consumer_key ||= OAuth::Consumer.new "TWaKQAMjCCJBJH6Gz8Pp1EeLX", "CHIS41dDObbEP6aBRl5fOTVTTsg1vKG1ngvvRtA6g52kibEK9s"
access_token ||= OAuth::Token.new "2518936561-ZTI6mTh4uaJaL8c3Llo4ARr6dX4zygx7LbrPcIe", "tbY7jzEOma0Y5hxSBBrtTqW9khF7ikKGWG0lj79YIC1co"

# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweets = nil
puts response.code
if response.code == '200' then
  puts "Responded"
  tweets = JSON.parse(response.body)
  print_timeline(tweets)
end
nil
