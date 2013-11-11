require "bundler"

require 'rake/testtask'
require './app/sports_manager'

task default: :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

namespace :sb do
  desc "Get all the tickets from the last 6 months"
  task :season_tickets do
    Tickets.save_tickets(SportsbookApi.get_tickets)
    Tickets.save_tickets(SportsbookApi.get_tickets_previous_month)
    Tickets.save_tickets(SportsbookApi.get_tickets_previous_month_2)
    Tickets.save_tickets(SportsbookApi.get_tickets_previous_month_3)
    Tickets.save_tickets(SportsbookApi.get_tickets_previous_month_4)
    Tickets.save_tickets(SportsbookApi.get_tickets_previous_month_5)
  end
end