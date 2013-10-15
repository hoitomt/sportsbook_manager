get '/tickets/?' do
  @tickets = Ticket.all
  @tags = Tag.all
  slim :'tickets/index', layout: :'layouts/application'
end

get '/tickets/update/?' do
  Tickets.save_tickets(SportsbookApi.get_tickets)
  slim :'tickets/index', layout: :'layouts/application'
end