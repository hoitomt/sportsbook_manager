get '/tickets/?' do
  @tickets = Ticket.all
  @tags = Tag.all
  slim :'tickets/index', layout: :'layouts/application'
end

get '/tickets/update/?' do
  Tickets.save_tickets(SportsbookApi.get_tickets)
  slim :'tickets/index', layout: :'layouts/application'
end

post '/tickets/:id/add_tag' do
  p "Params #{params}"
  tag = Tag.find(params[:tag_id])
  ticket = Ticket.find(params[:id])
  ticket.add_tag(tag)
  redirect '/tickets'
end