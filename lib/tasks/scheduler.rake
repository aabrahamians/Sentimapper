desc "This task is called by the Heroku scheduler add-on"
task :update_tweets => :environment do
  puts "Updating tweets..."
	@la_latlong = "-118.607866,33.685122,-117.705614,34.275003"
	Tweet.delete_all
	sniffer = TweetSniffer.new(@la_latlong)
	sniffer.getStream()
  puts "done."
end