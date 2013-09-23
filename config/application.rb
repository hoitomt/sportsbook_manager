require 'mongo'

configure do
  enable :logging
  set :mongo_database_name, 'sports_manager'
  set :mongo_client, Mongo::MongoClient.new
end

require_relative "environments/#{settings.environment}"
