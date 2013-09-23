class Tickets

  class << self

    def all_tickets
      MongoDao.all.each_with_object([]) do |ticket_data, a|
        a << Ticket.new(ticket_data)
      end
    end

    def save_tickets(tickets)
      tickets.each do |ticket|
        persist_ticket(ticket)
      end
    end

    private

    def persist_ticket(ticket)
      MongoDao.add_or_update({'sb_bet_id' => ticket.sb_bet_id}, parse_ticket(ticket))
    end

    def parse_ticket(ticket)
      p "Ticket #{ticket.attributes}"
      ticket.to_hash
    end

  end

end