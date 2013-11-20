$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')
ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require './app/sports_manager'
require 'nokogiri'
require 'capybara'
require 'capybara/dsl'

module TestHelper
  include Capybara::DSL

  def clear_database
    DataMapper.auto_migrate!
  end

  def load_fixture(fixture_name)
    doc = File.read(File.expand_path(File.dirname(__FILE__) + "/fixtures/#{fixture_name}.html"))
    polish doc
  end

  def load_yml_fixture(fixture_name)
    path = File.expand_path(File.dirname(__FILE__) + "/fixtures/yml/#{fixture_name}.yml")
    test_fixture = YAML.load_file(path)
    # p "Test Fixture #{test_fixture}"
    test_fixture['fixture'] = polish test_fixture['fixture']
    test_fixture
  end

  def polish(doc)
    doc.gsub!(/\\r|\\t|\\n|\\/, '')
    doc.gsub!(/\s{2,}/, ' ')
    Nokogiri::HTML(doc)
  end

end