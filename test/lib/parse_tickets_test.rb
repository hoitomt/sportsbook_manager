require 'test_helper'

describe SportsbookApi::ParseTickets do
  include TestHelper

  let(:response){load_fixture('watir')}

  describe 'parse tickets' do
    let(:tickets){SportsbookApi::ParseTickets.new(response).extract}
    let(:first_ticket){tickets.first}

    it 'should parse the file' do
      tickets.length.must_equal 25
    end

    it 'should set the attributes' do
      first_ticket.sb_bet_id.must_equal 421783268
      first_ticket.amount_wagered.must_equal 5.0
      first_ticket.amount_to_win.must_equal 4.55
      first_ticket.outcome.must_equal 'Lost'
    end
  end

  describe 'parse line items' do
    let(:game){load_fixture('single_game')}
    let(:line_item){SportsbookApi::ParseTickets.new(response).create_line_item(game)}
    let(:line_item_date){Time.new(2013, 8, 29, 18, 05)}

    it "should parse the away_team" do
      line_item[:away_team].must_equal 'NorthCarolina'
      line_item[:home_team].must_equal 'SCarolina'
      line_item[:away_score].must_equal '10'
      line_item[:home_score].must_equal '27'
      line_item[:line_item_date].must_equal line_item_date
      line_item[:line_item_spread].must_equal 'SCarolina -13 (-105)'
    end
  end

  describe "parse different types of line items" do
    let(:sportsbook){ SportsbookApi::ParseTickets.new({}) }

    describe "parse teams" do
      test_types =['pending_game', 'single_game', 'single_half', 'pending_single_half']

      test_types.each do |test_type|
        it "should test #{test_type}" do
          fixture = load_yml_fixture(test_type)
          sb = sportsbook.create_line_item(fixture['fixture'])
          compare_ticket(fixture['expected_result'], sb)
        end
      end
    end
  end

  def compare_ticket(fixture, result)
    fixture['away_team'].must_equal result[:away_team]
    fixture['away_score'].must_equal result[:away_score]
    fixture['home_team'].must_equal result[:home_team]
    fixture['home_score'].must_equal result[:home_score]
    fixture['line_item_spread'].must_equal result[:line_item_spread]
  end

end
