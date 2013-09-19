get '/tickets' do
  @tickets = SportsbookApi.get_tickets
  slim :'tickets/index', layout: :'layouts/application'
end