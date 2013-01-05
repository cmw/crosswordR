# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CrosswordR::Application.initialize!

require 'yaml'
APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")