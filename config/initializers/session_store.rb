# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_summer_league_session',
  :secret      => '0a66b296ddfa29ba6b36ec31568d5ef55e1b16fcb0d7ea8eee94ee5e803eb26a7e8dc7cb5e57c1d81e413619229fdbdbd3f6a4fa6e87a788e6945b9b07afa315'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
