require 'sinatra'
require 'sportsbook_api'

require_relative '../config/application'

# set :root, File.expand_path(File.dirname(__FILE__), "../../")
# p "Root #{settings.root}"

credentials = YAML.load_file(File.expand_path("config/sportsbook_credentials.yml"))
SportsbookApi.configure do |config|
  config.username = credentials['username']
  config.password = credentials['password']
end

require_relative 'routes/pages'
require_relative 'routes/tickets'
require_relative 'models/ticket'
