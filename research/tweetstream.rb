require 'tweetstream'
require 'csv'
require 'json'

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

count = 0

CSV.open("tweets.csv", "w") do |csv|
  csv << [ "id","user_name","text","latitude","longitude","lang"]
    client.locations("-118.610602,33.733438,-118.048926,34.281011") do |status, client|
	  puts "ID: #{status.id}"
	  puts "User: #{status.user.name}"
	  puts "Text: #{status.text}"
	  puts "Geo: [#{status.geo.coordinates[0]},#{status.geo.coordinates[1]}]"
	  if status.respond_to?("coordinates")
	  	puts "Coordinates: [#{status.coordinates["coordinates"][0]},#{status.coordinates["coordinates"][1]}]"
	  end
	  if status.respond_to?("place")
	  	puts "Place: #{status.place.name}"
	  end
	  if status.geo.coordinates[0].is_a?(Float) && status.geo.coordinates[1].is_a?(Float) && status.user.lang == "en" && status.place.name != "California"
	  	csv << ["#{status.id}","#{status.user.name}","#{status.text.delete('\n').delete('\r')}","#{status.geo.coordinates[0]}","#{status.geo.coordinates[1]}","#{status.user.lang}"]
	  	count += 1
	  end
	  puts "Count: #{count}"
	  if count >= 200
	  	client.stop
	  end
	end
end

#JSON converter
File.open("tweets.json",'w') do |json_file|
    jsonData = CSV.read("tweets.csv", 
    	:headers => true, :header_converters => :symbol).map{|csv_row| csv_row.to_hash}
    json_file.write(JSON.pretty_generate(jsonData));
end