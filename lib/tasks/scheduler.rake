desc "This task is called by the Heroku scheduler add-on"
task :update_tweets => :environment do
  puts "Updating tweets..."
	@la_latlong = "-118.575016,33.497282,-117.080875,34.181668"
	Tweet.delete_all
	sniffer = TweetSniffer.new(@la_latlong)
	sniffer.getStream()
  puts "done."
end