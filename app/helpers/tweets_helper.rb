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
end
