require 'json'
require 'pp'

json = File.read('tweets.json')
tweets = JSON.parse(json)

tweets.each do |t|
 puts t["text"]
end

# puts tweets[1]["user_name"]

# pp tweets