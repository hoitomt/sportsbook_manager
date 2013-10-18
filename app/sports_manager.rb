require 'bundler'
Bundler.require(:default)

require './lib/sportsbook_api/sportsbook_api'
require 'slim'
require 'active_support/core_ext'

require_relative '../config/application'

set :views, 'app/views'

credentials = YAML.load_file(File.expand_path("config/sportsbook_credentials.yml"))
SportsbookApi.configure do |config|
  config.username = credentials['username']
  config.password = credentials['password']
end

require_relative 'routes/pages'
require_relative 'routes/tickets'
require_relative 'routes/tags'
require_relative 'models/tag'
require_relative 'models/ticket_line_item'
require_relative 'models/ticket'
require_relative 'services/tickets'
require_relative 'services/mongo_dao'
require_relative 'helpers/ticket_helper'
