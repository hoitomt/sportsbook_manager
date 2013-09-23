require 'sinatra'
require 'sportsbook_api'
require 'slim'

require_relative '../config/application'

set :public_folder, 'app/assets'

credentials = YAML.load_file(File.expand_path("config/sportsbook_credentials.yml"))
SportsbookApi.configure do |config|
  config.username = credentials['username']
  config.password = credentials['password']
end

require_relative 'routes/pages'
require_relative 'routes/tickets'
require_relative 'models/ticket_line_item'
require_relative 'models/ticket'
require_relative 'services/tickets'
require_relative 'services/mongo_dao'
