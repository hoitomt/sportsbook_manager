get '/tickets' do
  @tickets = Tickets.all_tickets
  slim :'tickets/index', layout: :'layouts/application'
end

get '/tickets/update' do
  Tickets.save_tickets(SportsbookApi.get_tickets)
  slim :'tickets/index', layout: :'layouts/application'
end