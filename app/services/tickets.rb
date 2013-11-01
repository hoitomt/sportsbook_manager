class Tickets
  class << self

    def save_tickets(tickets)
      tickets.each do |ticket|
        persist_ticket(ticket)
      end
    end

    private

    def persist_ticket(ticket)
      saved_ticket = persist_base_ticket(ticket)
      ticket.ticket_line_items.each do |line_item|
        persist_ticket_line_item(saved_ticket, line_item)
      end
    end

    def persist_base_ticket(ticket)
      ticket_attributes = ticket.attributes.dup
      ticket_attributes.delete(:ticket_line_items)
      Ticket.create(ticket_attributes)
    end

    def persist_ticket_line_item(ticket, ticket_line_item)
      TicketLineItem.create(ticket_line_item.attributes.merge({ticket_id: ticket.id}))
    end

    def dao
      MongoDao.new('tickets')
    end

  end
end