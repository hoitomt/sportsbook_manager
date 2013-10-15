class Tickets

  class << self

    def save_tickets(tickets)
      p "Tickets #{tickets}"
      tickets.each do |ticket|
        persist_ticket(ticket)
      end
    end

    private

    def persist_ticket(ticket)
      dao.upsert({'sb_bet_id' => ticket.sb_bet_id}, parse_ticket(ticket))
    end

    def parse_ticket(ticket)
      p "Ticket #{ticket.attributes}"
      ticket.to_hash
    end

    def dao
      MongoDao.new('tickets')
    end

  end

end