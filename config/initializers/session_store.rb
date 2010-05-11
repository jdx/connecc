# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_connecc_session',
  :secret => '31e11cd7cf41026f47dcdd1ee7e369f52fb3a7a286b7987a0bc767be6aa5ad75f77300447f903316c5a34491efbab28d1ec6027c7a662773bf46382609a675d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
