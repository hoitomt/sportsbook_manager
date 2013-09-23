class Ticket
  include Virtus

  attribute :_id,               BSON::ObjectId
  attribute :sb_bet_id,         Integer
  attribute :wager_date,        Time
  attribute :type,              String
  attribute :amount_wagered,    Float
  attribute :amount_to_win,     Float
  attribute :outcome,           String
  attribute :ticket_line_items, Array[TicketLineItem]

  def display_date
    wager_date.strftime("%_m/%e/%y")
  end
end