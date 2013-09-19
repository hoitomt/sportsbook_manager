require 'slim'

configure do
  enable :logging
end

require_relative "environments/#{settings.environment}"
