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

def strip_control_and_extended_characters(text)
	text.chars.inject("") do |str, char|
  		if char.ascii_only? and char.ord.between?(32,126)
    		str << char
  		end
  		str
	end
end

def calculateSentiment(original_text)
	csvPath = "afinn.csv"

	afinn = {}

	CSV.foreach(csvPath, { :headers => false } ) do |csv|
		afinn[csv[0]] = csv[1] #afinn["word"] = score 
	end

	text = original_text.downcase.gsub(/'/, '').gsub(/[^a-z0-9]/, ' ').gsub(/\s+/, ' ').strip
	count = 0
	sum = 0
	afinn.each do |word, score|
		pattern = /\b#{word}\b/i
		while text =~ pattern
	  		text.sub! pattern, ''
	  		sum += score.to_f
	  		count += 1
		end
	end
	if count > 0
		sum / count.to_f
	else
		0
	end
end

count = 0

CSV.open("tweets.csv", "w") do |csv|
  csv << [ "tweet_id","user_name","text","latitude","longitude","sentiment"]
    client.locations("-118.575016,33.497282,-117.080875,34.181668") do |status, client|
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
	  	cleantext = strip_control_and_extended_characters(status.text.gsub(/[\t\n\r]/, '  '))
	  	cleanName = strip_control_and_extended_characters(status.user.name.gsub(/[\t\n\r]/, '  '))
	  	csv << ["#{status.id}","#{cleanName}","#{cleantext}","#{status.geo.coordinates[0]}","#{status.geo.coordinates[1]}","#{calculateSentiment(cleantext)}"]
	  	puts "Sentiment: #{calculateSentiment(cleantext)}"
	  	count += 1
	  end
	  puts "Count: #{count}"
	  if count >= 1
	  	client.stop
	  end
	end
end

# CSV.open("new.csv", "wb") do |file|
# 	CSV.foreach("tweets.csv", { :headers => false } ) do |csv|
# 		cleanName = strip_control_and_extended_characters(csv[1].gsub(/[\t\n\r]/, '  '))
# 		file << [csv[0],cleanName,csv[2],csv[3],csv[4],csv[5]]
# 	end
# end

#JSON converter
File.open("tweets.json",'w') do |json_file|
    jsonData = CSV.read("tweets.csv", 
    	:headers => true, :header_converters => :symbol).map{|csv_row| csv_row.to_hash}
    json_file.write(JSON.pretty_generate(jsonData));
end