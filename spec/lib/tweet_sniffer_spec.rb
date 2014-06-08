require 'spec_helper'

describe TweetSniffer do

  describe "calculateSentiment()" do

  	it "should return the appropriate negative sentiment for a given text" do
  	  ts = TweetSniffer.new("0,0","LA")
  	  score = ts.calculateSentiment("I am so sad and depressed today...")
  	  expect(score).to eql(-2.0)
  	end

  	it "should return the appropriate positive sentiment for a given text" do
  	  ts = TweetSniffer.new("0,0","LA")
  	  score = ts.calculateSentiment("I am so happy and excited today...")
  	  expect(score).to eql(3.0)
  	end

  end

end