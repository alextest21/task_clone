# Load the Rails application.
require File.expand_path('../application', __FILE__)

Time::DATE_FORMATS[:create_date] = "%d.%m.%Y, %H:%M"

# Initialize the Rails application.
Rails.application.initialize!
