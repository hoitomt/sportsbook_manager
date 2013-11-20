get '/summary/?' do
  @results = Finances.all
  slim :'summary/index', layout: :'layouts/application'
end