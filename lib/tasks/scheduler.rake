task :update_tweets => [:delete_tweets, :update_LA, :update_SF, :update_SEA] do
  desc "This task is called by the Heroku scheduler add-on"
  puts "Updated all tweets :)"
end

task :delete_tweets => :environment do
	puts "Deleting old tweets..."
	Tweet.delete_all
end

task :update_LA => :environment do
  puts "Updating LA tweets..."
	@la_latlong = "-118.607866,33.685122,-117.705614,34.275003"
	snifferLA = TweetSniffer.new(@la_latlong, "LA")
	snifferLA.getStream(200)
  puts "done."
end

task :update_SF => :environment do
  puts "Updating SF tweets..."
	@sf_latlong = "-122.546534,37.472669,-121.977992,37.834182"
	snifferSF = TweetSniffer.new(@sf_latlong, "SF")
	snifferSF.getStream(200)
  puts "done."
end

task :update_SEA => :environment do
  puts "Updating SEA tweets..."
	@sea_latlong = "-122.426909,47.432663,-122.001189,47.760030"
	snifferSEA = TweetSniffer.new(@sea_latlong, "SEA")
	snifferSEA.getStream(200)
  puts "done."
end