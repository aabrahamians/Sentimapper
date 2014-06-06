require 'spec_helper'

describe TweetsController do
	context 'when format is HTML' do
		describe "GET 'index' " do
			it "renders index template for index" do
				get :index
				expect(response).to render_template :index
			end
			it "returns http success" do
				Tweet.should_receive(:all).and_return "All our posts"
				get 'index'
				expect(assigns(:posts)).to eq "All our posts"
				response.should be_success
			end
		end

		# describe "GET 'show' " do
		# 	it 'returns http success' do
		# 		Tweet.should_receive(:find).with("123").and_return("A post")
		# 		get 'show', {id: 123}
		# 		expect(assigns(:tweet)).to eq "A post"
		# 		response.should be_success
		# 	end
		# end
	end
end