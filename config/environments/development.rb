configure do
  set :db_url, 'pghoitomt.cxmionxxowkc.us-east-1.rds.amazonaws.com'
  set :db_port, '5432'
  set :db_user, 'hoitomt'
  set :db_password, 'W1sc0k1d'
end

DataMapper.setup(:default, "postgres://#{settings.db_user}:#{settings.db_password}@#{settings.db_url}")