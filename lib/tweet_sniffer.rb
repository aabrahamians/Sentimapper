require 'tweetstream'
require 'csv'
require 'json'

class TweetSniffer
    def initialize(latlong)
        @latlong = latlong
		
		TweetStream.configure do |config|
		  config.consumer_key       = 'TWaKQAMjCCJBJH6Gz8Pp1EeLX'
		  config.consumer_secret    = 'CHIS41dDObbEP6aBRl5fOTVTTsg1vKG1ngvvRtA6g52kibEK9s'
		  config.oauth_token        = '2518936561-ZTI6mTh4uaJaL8c3Llo4ARr6dX4zygx7LbrPcIe'
		  config.oauth_token_secret = 'tbY7jzEOma0Y5hxSBBrtTqW9khF7ikKGWG0lj79YIC1co'
		  config.auth_method        = :oauth
		end

		@client = TweetStream::Client.new

		@client.on_error do |message|
  			puts message
		end

		#load in the AFINN word bank
		csvPath = "#{Rails.root}/app/assets/afinn.csv"
		@afinn = {}
		CSV.foreach(csvPath, { :headers => false } ) do |csv|
			@afinn[csv[0]] = csv[1] #afinn["word"] = score 
		end
    end

	def calculateSentiment(original_text)
		text = original_text.downcase.gsub(/'/, '').gsub(/[^a-z0-9]/, ' ').gsub(/\s+/, ' ').strip
		count = 0
		sum = 0
		@afinn.each do |word, score|
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

    def getStream(tweetCount)
  		# tweetsPath = "#{Rails.root}/app/assets/tweets.json"
  		# JSON.parse(File.read(tweetsPath))
  		count = 0
	 	@client.locations(@latlong) do |status, client|
		  puts "ID: #{status.id}"
		  puts "User: #{status.user.screen_name}"
		  puts "Text: #{status.text}"
		  puts "Geo: [#{status.geo.coordinates[0]},#{status.geo.coordinates[1]}]"
		  puts "Created: #{status.created_at}"
		  if status.respond_to?("place")
		  	puts "Place: #{status.place.name}"
		  end
		  if status.geo.coordinates[0].is_a?(Float) && status.geo.coordinates[1].is_a?(Float) && status.user.lang == "en" && status.place.name != "California"
		  	cleanText = status.text.gsub(/[\t\n\r]/, ' ')
		  	cleanName = status.user.screen_name.gsub(/[\t\n\r]/, ' ')
		  	Tweet.create(tweet_id:"#{status.id}",
		  		user_name:"#{cleanName}",
		  		text:"#{cleanText}",
		  		latitude:"#{status.geo.coordinates[0]}",
		  		longitude:"#{status.geo.coordinates[1]}",
		  		sentiment:"#{calculateSentiment(cleanText)}",
		  		created_at:"#{status.created_at}")
		  		puts "Sentiment: #{calculateSentiment(cleanText)}"
		  	count += 1
		  end
		  puts "Count: #{count}"
		  if count >= tweetCount
		  	client.stop
		  end
		end
    end

end
