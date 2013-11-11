class Ticket
  include DataMapper::Resource

  property :id, Serial
  property :sb_bet_id,         Integer
  property :wager_date,        Time
  property :type,              String
  property :amount_wagered,    Float
  property :amount_to_win,     Float
  property :outcome,           String

  has n, :ticket_line_items
  has n, :ticket_tags
  has n, :tags, :through => :ticket_tags

  def self.add_or_update(t_hash={})
    ticket = Ticket.first(sb_bet_id: t_hash[:sb_bet_id])
    if ticket
      ticket.update(t_hash)
    else
      ticket = Ticket.create(t_hash)
    end
    ticket
  end

  def display_date
    wager_date.strftime("%_m/%-d/%y")
  end

  def outcome_class
    return 'default' if outcome.blank?
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
    {'lost' => 'danger', 'action' => 'warning', 'won' => 'success', 'pending' => 'default'}
  end

end
