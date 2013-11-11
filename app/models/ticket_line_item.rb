require 'cgi'

class TicketLineItem
  include DataMapper::Resource

  property :id, Serial
  property :ticket_id,         Integer
  property :away_team,         String
  property :away_score,        Integer
  property :home_team,         String
  property :home_score,        Integer
  property :line_item_date,    Time
  property :line_item_spread,  String

  belongs_to :ticket

  def self.add_or_update(tle_hash)
    ticket_line_item = existing_ticket_line_item(tle_hash)
    if ticket_line_item
      ticket_line_item.update(tle_hash)
    else
      ticket_line_item = TicketLineItem.create(tle_hash)
    end
    ticket_line_item
  end

  def self.existing_ticket_line_item(tle_hash)
    criteria = {
        ticket_id: tle_hash[:ticket_id],
        away_team: tle_hash[:away_team],
        home_team: tle_hash[:home_team],
        line_item_spread: tle_hash[:line_item_spread]
      }
    TicketLineItem.first(criteria)
  end

  def team_display
    "#{away_team} at #{home_team}"
  end

  def date_display
    line_item_date.strftime("%_m/%-d/%y")
  end

  def line_item_spread_display
    CGI.unescapeHTML(line_item_spread)
  end
end
