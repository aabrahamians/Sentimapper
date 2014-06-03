# encoding: utf-8
require 'csv'

# csvPath = "afinn.csv"

# afinn = {}

# CSV.foreach(csvPath, { :headers => false } ) do |csv|
# 	afinn[csv[0]] = csv[1] #afinn["word"] = score 
# end

# puts afinn["n00b"]
# puts afinn["myth"]

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
		puts "#{sum / count.to_f} + count: #{count}"
	else
		puts 0
	end
end

teststring = "Yayyy zumba tonight! #zumba #dance #fitness #groupfitness #equinox #equinoxbh #equinoxbeverlyhillsΓÇª http://t.co/Scpa6xyzDC"

calculateSentiment(teststring)