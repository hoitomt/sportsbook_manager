class Ticket
  include DataMapper::Resource

  property :id, Serial
  property :sb_bet_id,         Integer
  property :wager_date,        Time
  property :type,              String
  property :amount_wagered,    Float
  property :amount_to_win,     Float
  property :outcome,           String

  def self.add_or_update(t_hash)
    Ticket.first(sb_bet_id: t_hash[:sb_bet_id]) || Ticket.new(t_hash)
  end

  def display_date
    wager_date.strftime("%_m/%e/%y")
  end

  def outcome_class
    return '' unless outcome
    bootstrap[outcome.downcase]
  end

  def ticket_line_items
    TicketLineItem.all(ticket_id: id)
  end

  def add_tag(tag, amount)
    TicketTag.create(ticket_id: id, tag_id: tag.id, amount: amount)
  end

  def ticket_tags
    TicketTag.all(ticket_id: id) || []
  end

  private

  def bootstrap
    {'lost' => 'danger', 'action' => 'warning', 'won' => 'success'}
  end

end

DataMapper.finalize