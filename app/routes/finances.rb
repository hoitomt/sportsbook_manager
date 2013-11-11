get '/finances/?' do

  slim :'finances/index', layout: :'layouts/application'
end