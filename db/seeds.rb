# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  tweetsPath = "#{Rails.root}/app/assets/tweets.json"
  tweets = JSON.parse(File.read(tweetsPath))
  tweets.each do |tweet|
  	Tweet.create!(tweet)
  end
