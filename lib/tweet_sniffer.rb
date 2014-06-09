require 'tweetstream'
require 'csv'
require 'json'

class TweetSniffer
    def initialize(latlong, location)
        @latlong = latlong
		@location = location

		TweetStream.configure do |config|
		  config.consumer_key       = ENV['CONSUMER_KEY']
		  config.consumer_secret    = ENV['CONSUMER_SECRET']
		  config.oauth_token        = ENV['OAUTH_TOKEN']
		  config.oauth_token_secret = ENV['OAUTH_SECRET']
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
		  if status.geo.coordinates[0].is_a?(Float) && status.geo.coordinates[1].is_a?(Float) && status.user.lang == "en" && status.place.name != "California" && status.place.name != "Washington"
		  	cleanText = status.text.gsub(/[\t\n\r]/, ' ')
		  	cleanName = status.user.screen_name.gsub(/[\t\n\r]/, ' ')
		  	Tweet.create(tweet_id:"#{status.id}",
		  		user_name:"#{cleanName}",
		  		text:"#{cleanText}",
		  		latitude:"#{status.geo.coordinates[0]}",
		  		longitude:"#{status.geo.coordinates[1]}",
		  		sentiment:"#{calculateSentiment(cleanText)}",
		  		created_at:"#{status.created_at}",
		  		location: @location)
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
