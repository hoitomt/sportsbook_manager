require 'cgi'

class TicketLineItem
  include Virtus

  attribute :away_team,         String
  attribute :away_score,        Integer
  attribute :home_team,         String
  attribute :home_score,        Integer
  attribute :line_item_date,    Time
  attribute :line_item_spread,  String

  def team_display
    "#{away_team} at #{home_team}"
  end

  def date_display
    line_item_date.strftime("%_m/%e/%y")
  end

  def line_item_spread_display
    CGI.unescapeHTML(line_item_spread)
  end
end
