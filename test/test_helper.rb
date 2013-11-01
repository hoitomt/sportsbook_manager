$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'minitest/autorun'
require './app/sports_manager'
require 'nokogiri'

module TestHelper

  def clear_database
    DataMapper.auto_migrate!
  end

  def sportsbook_response
    doc = File.read(File.expand_path(File.dirname(__FILE__) + '/fixtures/sportsbook_response.html'))
    polish doc
  end

  def sportsbook_game
    doc = File.read(File.expand_path(File.dirname(__FILE__) + '/fixtures/sportsbook_game.html'))
    polish doc
  end

  def sportsbook_watir
    doc = File.read(File.expand_path(File.dirname(__FILE__) + '/fixtures/watir_fixture.html'))
    polish doc
  end

  def polish(doc)
    doc.gsub!(/\\r|\\t|\\n|\\/, '')
    doc.gsub!(/\s{2,}/, ' ')
    Nokogiri::HTML(doc)
  end

end