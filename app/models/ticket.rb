class Ticket
  include Virtus

  COLLECTION = "tickets"

  attribute :_id,               BSON::ObjectId
  attribute :sb_bet_id,         Integer
  attribute :wager_date,        Time
  attribute :type,              String
  attribute :amount_wagered,    Float
  attribute :amount_to_win,     Float
  attribute :outcome,           String
  attribute :ticket_line_items, Array[TicketLineItem]
  attribute :tags,              Array[Tag]

  def self.all
    dao.all(default_sort).each_with_object([]) do |ticket_data, a|
      a << Ticket.new(ticket_data)
    end
  end

  def self.dao
    MongoDao.new(COLLECTION)
  end

  def self.default_sort
    {:sort => {'wager_date' => :desc}}
  end

  def id
    @_id.to_s
  end

  def display_date
    wager_date.strftime("%_m/%e/%y")
  end

  def outcome_class
    outcome ? outcome.downcase : ''
  end
end