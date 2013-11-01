helpers do
  def currency(amount)
    return '$0.00' if amount.blank?
    sprintf("$%.2f", amount)
  end

  def unused_tags(ticket)
    ticket_tag_ids = ticket.ticket_tags.map{|t_tag| t_tag.tag_id}
    unless ticket_tag_ids.blank?
      p "tag id #{ticket_tag_ids}"
      p "All Tags #{all_tags.inspect}"
    end
    all_tags.reject{|tag| ticket_tag_ids.include?(tag.id)}
  end

  def all_tags
    @all_tags ||= Tag.all
  end

  def panel_class(outcome)

  end
end
