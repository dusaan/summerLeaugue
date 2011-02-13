# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_plugin_session',
  :secret      => 'a33645b72e2a8f6bd425d957d4eba376a5f59fcfcf10365a5cd1a2b4fa606309f4c22ab947685706594a06a2cc6a1a84f6c22aefe9115f7ef1ad31aebbb7be98'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
