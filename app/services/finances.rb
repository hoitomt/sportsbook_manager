class Finances
  class << self
    Struct.new("Finance", :id, :amount_wagered, :amount_won, :amount_pending, :bottom_line)

    def all
      {}.tap do |h|
        tagged_finances.each do |k, fin|
          amount_wagered = amount_wagered(fin)
          amount_won = amount_won(fin)
          amount_pending = amount_pending(fin)
          bottom_line = bottom_line(amount_wagered, amount_won, amount_pending)
          h[k] = Struct::Finance.new(fin.first.id, amount_wagered, amount_won, amount_pending, bottom_line)
        end
      end
    end

    def tagged_finances
      tagged_finances = finances.each_with_object({}) do |finance, h|
        if h[finance.name]
          h[finance.name] << finance
        else
          h[finance.name] = [finance]
        end
      end
    end

    def finances
      repository.adapter.select(finances_query)
    end

    def finances_query
      <<-querystring
        SELECT ta.id, ta.name, tt.amount as "tag_amount", t.amount_wagered, t.amount_to_win, t.outcome, t.wager_date, t.sb_bet_id
        FROM tags ta
        JOIN ticket_tags tt on tt.tag_id = ta.id
        JOIN tickets t on t.id = tt.ticket_id
        ORDER BY ta.name asc, t.wager_date asc
      querystring
    end

    def amount_wagered(finances)
      sum_array finances.map{|finance| finance.tag_amount}
    end

    def amount_won(finances)
      sum_array finances.map{|finance| calculated_amount(finance)}
    end

    def amount_pending(finances)
      sum_array finances.map{|finance| calculated_amount_pending(finance)}
    end

    def bottom_line(wagered, won, pending)
      won - (wagered + pending)
    end

    def sum_array(arr=[])
      arr.inject{|sum, amount| sum + amount}
    end

    def calculated_amount(finance)
      if finance.outcome.downcase.match("won")
        calculated_amount_won(finance)
      elsif finance.outcome.downcase.match("action")
        calculated_amount_push(finance)
      else
        0
      end
    end

    def calculated_amount_won(finance)
      percent_of_wager = finance.tag_amount / finance.amount_wagered
      finance.tag_amount + (finance.amount_to_win * percent_of_wager) || 0
    end

    def calculated_amount_push(finance)
      finance.tag_amount
    end

    def calculated_amount_pending(finance)
      finance.outcome.downcase.match("pending") ? finance.tag_amount : 0
    end

  end
end