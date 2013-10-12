require 'bundler'
Bundler.require(:default)
require 'sass/plugin/rack'
require './app/sports_manager'

use Sass::Plugin::Rack

use Rack::Coffee, root: 'public', urls: '/javascripts'

run Sinatra::Application