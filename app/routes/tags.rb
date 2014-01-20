get '/tags/edit/:id' do
  @tag = Tag.find(params[:id])
  slim :'tags/edit', layout: :'layouts/application'
end

get '/tags/new' do
  @tag = Tag.new
  slim :'tags/new', layout: :'layouts/application'
end

get '/tags/?' do
  @tags = Tag.all
  slim :'tags/index', layout: :'layouts/application'
end

get '/tags/:id/cash/new' do
  @tag = Tag.get(params[:id])
  @cash = Cash.new
  slim :'cash/new', layout: :'layouts/application'
end

post '/tags/:id/cash' do
  p "Params #{params}"
  @cash = Cash.create(tag_id: params[:id], amount: params[:cash][:amount])
  redirect '/tags'
end

post '/tags/:id' do
  @tag = Tag.find(params[:id])
  @tag.update(params)
  redirect '/tags'
end

post '/tags/?' do
  p "Params #{params} - #{params[:tag]}"
  @tag = Tag.new(params[:tag])
  @tag.save
  redirect '/tags'
end

delete '/tags/:id' do
  tag = Tag.find(params[:id])
  tag.delete
  redirect '/tags'
end