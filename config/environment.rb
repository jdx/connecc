# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Connecc::Application.initialize!

US_STATES = [ "AK","AL","AR","AS","AZ","CA","CO","CT","DC","DE","FL","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"];

FRONTEND_CONFIGURATION = { :merchant_id => ENV['CONNECC_GOOGLE_MERCHANT_ID'], :merchant_key => ENV['CONNECC_GOOGLE_MERCHANT_KEY'], :use_sandbox => true }
