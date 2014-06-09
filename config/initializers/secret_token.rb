# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
SentiMapper::Application.config.secret_key_base = '982dcf4f26625092c6f123a17d0dc4a35586b'

unless Rails.env.production?
	ENV['CONSUMER_KEY'] = 'TWaKQAMjCCJBJH6Gz8Pp1EeLX'
	ENV['CONSUMER_SECRET'] = 'CHIS41dDObbEP6aBRl5fOTVTTsg1vKG1ngvvRtA6g52kibEK9s'
	ENV['OAUTH_TOKEN'] = '2518936561-ZTI6mTh4uaJaL8c3Llo4ARr6dX4zygx7LbrPcIe'
	ENV['OAUTH_SECRET'] = 'tbY7jzEOma0Y5hxSBBrtTqW9khF7ikKGWG0lj79YIC1co'
end