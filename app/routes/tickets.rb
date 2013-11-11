get '/tickets/?' do
  @tickets = Ticket.all(order: [:wager_date.desc])
  slim :'tickets/index', layout: :'layouts/application'
end

get '/tickets/update/?' do
  Tickets.save_tickets(SportsbookApi.get_tickets)
  redirect '/tickets'
end

post '/tickets/:id/add_tag' do
  p "Add Params #{params}"
  tag = Tag.get(params[:tag_id])
  ticket = Ticket.get(params[:id])
  ticket_tag = ticket.add_tag(tag, params[:amount])
  if ticket_tag.errors.present?
    status 422
    ticket_tag.errors.to_json
  else
    slim :'ticket_tags/ticket_tag', locals: {ticket: ticket}
  end
end

post '/tickets/:id/remove_tag' do
  p "Remove Params #{params}"
  ticket = Ticket.get(params[:ticket_id])
  ticket_tag = TicketTag.get(params[:ticket_tag_id])
  ticket_tag.destroy
  if ticket_tag.errors.present?
    status 422
    ticket_tag.errors.to_json
  else
    slim :'ticket_tags/ticket_tag', locals: {ticket: ticket}
  end
end