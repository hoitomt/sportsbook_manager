class Finances
  class << self
    Struct.new("Finance", :id, :name, :amount_wagered, :amount_won, :amount_pending)

    def all
      {}.tap do |h|
        tagged_finances.each do |k, finances|
          h[k] = Struct::Finance.new(k,
                                     finances.first.name,
                                     amount_wagered(finances),
                                     amount_won(finances),
                                     amount_pending(finances))
        end
      end
    end

    def tagged_finances
      tagged_finances = finances.each_with_object({}) do |finance, h|
        if h[finance.id]
          h[finance.id] << finance
        else
          h[finance.id] = [finance]
        end
      end
    end

    def finances
      repository.adapter.select(finances_query)
    end

    def finances_query
      <<-querystring
        SELECT ta.id, ta.name, tt.amount as "tag_amount", t.amount_wagered, t.amount_to_win, t.outcome
        FROM tags ta
        JOIN ticket_tags tt on tt.tag_id = ta.id
        JOIN tickets t on t.id = tt.ticket_id
        ORDER BY ta.name asc
      querystring
    end

    def amount_won(finances)
      finances.inject do |sum, finance|
        h = calculated_amount(finance, "won")
        h + 1
        p "Sum #{sum}"
        p "h #{h}"
        sum + calculated_amount(finance, "won")
      end
    end

    def amount_wagered(finances)
      finances.inject do |sum, finance|
        sum + finance.tag_amount
      end
    end

    def amount_pending(finances)
      finances.inject do |sum, finance|
        sum + calculated_amount(finance, "active")
      end
    end

    def calculated_amount(finance, status)
      percent_of_wager = finance.tag_amount / finance.amount_wagered
      amount_won = (finance.amount_wagered + finance.amount_to_win) * percent_of_wager
      finance.outcome.downcase.match(status) ? amount_won : 0
    end

  end
end