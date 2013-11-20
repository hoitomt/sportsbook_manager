require 'test_helper'

describe Tickets do
  include TestHelper

  let(:response){load_fixture('watir')}
  let(:sb_tickets){SportsbookApi::ParseTickets.new(response).extract}
  let(:sb_first_ticket){sb_tickets.first}

  def setup
    clear_database
  end

  describe 'create one ticket' do

    before do
      Tickets.send(:persist_ticket, sb_first_ticket)
    end

    it "should add a ticket to db" do
      Ticket.count.must_equal 1
    end

    it "should create a ticket" do
      t = Ticket.first
      t.sb_bet_id.must_equal 421783268
      t.type.must_equal "Straight Wager"
      t.ticket_line_items.length.must_equal 1
    end
  end

  describe 'create tickets' do
    before do
      Tickets.save_tickets(sb_tickets)
    end

    it "should many tickets" do
      Ticket.count.must_equal 25
    end
  end

  describe 'create line items' do
    before do
      Tickets.save_tickets(sb_tickets)
    end

    it "should create many line items" do
      t = Ticket.first(sb_bet_id: 420440997)
      t.ticket_line_items.length.must_equal 2
    end

    it "should create many line items" do
      t = Ticket.first(sb_bet_id: 420440997)
      first_line = t.ticket_line_items.first
      first_line.away_team.must_equal 'Iowa'
      first_line.home_team.must_equal 'MinnesotaU'
      last_line = t.ticket_line_items.last
      last_line.away_team.must_equal 'LSU'
      last_line.home_team.must_equal 'Georgia'
    end
  end
end