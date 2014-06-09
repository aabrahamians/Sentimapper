module TweetsHelper

	def calcPiePercentages(tweets)
        neg = 0.0
        post = 0.0

        tweets.each do |t|
          if t["sentiment"] < 0
            neg += 1
          elsif t["sentiment"] > 0
            post += 1
          end
        end

        if neg > 0 && post > 0
        	negpercent = neg/(neg+post)
        	pospercent = post/(neg+post)
        elsif neg > 0
            negpercent = 1.0
            pospercent = 0.0
        elsif post > 0
            pospercent = 1.0
            negpercent = 0.0
        end

        [negpercent,pospercent]
    end

    def calcSentimentFrequency(tweet)
        val = []
        val[0] = 0 #-5...4
        val[1] = 0 #-4...-3
        val[2] = 0 #-3...-2
        val[3] = 0 #-2...-1
        val[4] = 0 #-1...0
        val[5] = 0 #0...1
        val[6] = 0 #1...2
        val[7] = 0 #2...3
        val[8] = 0 #3...4
        val[9] = 0 #4...5
        val[10] = 0 #5

        tweet.each do |t|
            case t["sentiment"]
                when -5.0...-4.0
                    val[0] += 1
                when -4.0...-3.0
                    val[1] += 1
                when -3.0...-2.0
                    val[2] += 1
                when -2.0...-1.0
                    val[3] += 1
                when -1.0...0.0
                    val[4] += 1
                when 0.0...1.0
                    val[5] += 1
                when 1.0...2.0
                    val[6] += 1
                when 2.0...3.0
                    val[7] += 1
                when 3.0...4.0
                    val[8] += 1
                when 4.0...5.0
                    val[9] += 1
                when 5.0
                    val[10] += 1
                else
                put "sentiment out of bounds"
                end 
        end
        return val
    end

end
