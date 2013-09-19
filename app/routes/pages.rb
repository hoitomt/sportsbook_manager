get '/' do
  p "Environment #{settings.environment}"
  slim :'pages/home', layout: :'layouts/application'
end