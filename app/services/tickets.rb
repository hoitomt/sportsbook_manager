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
      ticket_hash = ticket.attributes
      ticket_hash.delete(:ticket_line_items)
      Ticket.add_or_update(ticket_hash)
    end

    def persist_ticket_line_item(ticket, ticket_line_item)
      TicketLineItem.add_or_update(ticket_line_item.attributes.merge({ticket_id: ticket.id}))
    end

  end
end